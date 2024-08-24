// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ICrypt } from '@crypt/interfaces/ICrypt.sol';

contract Crypt is ICrypt {
    address public immutable OWNER;

    int256 internal _number;

    mapping(address account => uint256 balance) internal _balances;

    modifier onlyOwner() {
        if (msg.sender != OWNER) {
            revert NotOwner(msg.sender);
        }

        _;
    }

    constructor(address owner_) {
        OWNER = owner_;
    }

    function _test(string[] calldata) internal {
        ++_number;
    }
}
