// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Test } from '@forge/Test.sol';

interface IERC20 {
    function transfer(
        address to,
        uint256 amount
    ) external returns (bool succeess);
}

contract ERC20 {
    function transfer(
        address to,
        uint256 amount
    ) external returns (bool succeess) {}
}

contract CryptTests is Test {
    function test_testy() external pure {
        address to = address(1);
        uint256 amount = 256;

        bytes memory good = abi.encodeWithSignature(
            'transfer(address,uint256)',
            to,
            amount
        );

        bytes memory better = abi.encodeWithSelector(
            IERC20.transfer.selector,
            to,
            amount
        );
        bytes memory best = abi.encodeCall(IERC20.transfer, (to, amount));

        assertEq(good, better);
        assertEq(better, best);
    }
}
