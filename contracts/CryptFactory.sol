// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ICrypt } from '@crypt/interfaces/ICrypt.sol';
import { ICryptFactory } from '@crypt/interfaces/ICryptFactory.sol';

contract CryptFactory is ICryptFactory {

    ////////////////////////////////////////////////////////////////////////////
    // STATE                                                                  //
    ////////////////////////////////////////////////////////////////////////////

    address public immutable implementation;

    mapping(address owner => address crypt) public cryptOf;

    ////////////////////////////////////////////////////////////////////////////
    // CONSTRUCTOR                                                            //
    ////////////////////////////////////////////////////////////////////////////

    constructor(address implementation_) {
        implementation = implementation_;
    }

    ////////////////////////////////////////////////////////////////////////////
    // EXTERNAL FUNCTIONS                                                     //
    ////////////////////////////////////////////////////////////////////////////

    // TODO: Add `calls` and `deadline` to improve workflow.
    // TODO: Add array of `permit()` signatures for instant approval of calls.
    // TODO: Prevent anyone other than the `owner` from calling this function.
    function create(address owner) external returns (address crypt) {
        crypt = cryptOf[owner];

        if (crypt != address(0)) {
            revert CryptExists(crypt);
        }

        crypt = createProxy(owner);

        if (crypt == address(0)) {
            // TODO: What are all the reasons `create2` can fail?
            //       https://stackoverflow.com/a/74161700
        }

        cryptOf[owner] = crypt;

        // TODO: Also initialize with the `calls` and `deadline` as well.
        ICrypt(crypt).initialize(owner);

        emit CryptCreated(crypt, owner);
    }

    ////////////////////////////////////////////////////////////////////////////
    // INTERNAL FUNCTIONS                                                     //
    ////////////////////////////////////////////////////////////////////////////

    function createProxy(address owner) internal returns (address proxy) {
        address target = implementation;
        bytes32 salt = bytes32(bytes20(owner));

        // Uses a `create2` variation of ERC-1167 to create a minimal proxy.
        // NOTE: https://eips.ethereum.org/EIPS/eip-1167
        // TODO: What are the pros/cons of `create2` compared to `create`?
        // TODO: Can anyone else pre-deploy a malicious contract?
        assembly {
            mstore(
                0x00,
                or(
                    shr(0xe8, shl(0x60, target)),
                    0x3d602d80600a3d3981f3363d3d373d3d3d363d73000000
                )
            )
            mstore(
                0x20,
                or(shl(0x78, target), 0x5af43d82803e903d91602b57fd5bf3)
            )

            proxy := create2(0, 0x09, 0x37, salt)
        }
    }

}
