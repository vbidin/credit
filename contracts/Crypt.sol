// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ICrypt } from '@crypt/interfaces/ICrypt.sol';

contract Crypt is ICrypt {
    /// @notice Describes the current state of the contract.
    /// @dev    Bla bla bla...
    enum State {
        Created,
        Proceessing,
        Failed,
        Completed
    }

    struct Stuff {
        address account;
        bytes32 hash_;
        uint256 amount;
    }

    ////////////////////////////////////////////////////////////////////////////
    //                                  STATE                                 //
    ////////////////////////////////////////////////////////////////////////////

    uint256 internal constant HUNDRED_PERCENT = 1e6;

    address public immutable OWNER;

    uint256 internal count;
    bytes32 internal hashy;

    mapping(address account => uint256 balance) public balances;

    ////////////////////////////////////////////////////////////////////////////
    //                               CONSTRUCTOR                              //
    ////////////////////////////////////////////////////////////////////////////

    constructor(address owner) {
        OWNER = owner;
    }

    ////////////////////////////////////////////////////////////////////////////
    //                                MODIFIERS                               //
    ////////////////////////////////////////////////////////////////////////////

    modifier onlyOwner() {
        if (msg.sender != OWNER) {
            revert NotOwner(msg.sender);
        }

        _;
    }

    modifier onlyLender() {
        _;
    }

    modifier whenNotPaused() {
        _;
    }

    ////////////////////////////////////////////////////////////////////////////
    //                                FUNCTIONS                               //
    ////////////////////////////////////////////////////////////////////////////

    function doStuff() internal view returns (uint256 stuff) {
        stuff = 1337 + count;
    }
}
