// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ICrypt } from '@crypt/interfaces/ICrypt.sol';

contract Crypt is ICrypt {

    ////////////////////////////////////////////////////////////////////////////
    // CONSTANTS                                                              //
    ////////////////////////////////////////////////////////////////////////////

    address constant multicall = 0xcA11bde05977b3631167028862bE2a173976CA11;

    ////////////////////////////////////////////////////////////////////////////
    // STATE                                                                  //
    ////////////////////////////////////////////////////////////////////////////

    address public owner;
    uint256 public deadline;

    bool initialized;
    bool locked;

    Call[] calls;

    ////////////////////////////////////////////////////////////////////////////
    // INITIALIZATION                                                         //
    ////////////////////////////////////////////////////////////////////////////

    function initialize(address owner_) external notInitialized {
        owner = owner_;
        initialized = true;
    }

    ////////////////////////////////////////////////////////////////////////////
    // MODIFIERS                                                              //
    ////////////////////////////////////////////////////////////////////////////

    modifier notInitialized() {
        if (initialized) {
            revert AlreadyInitialized();
        }

        _;
    }

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert NotOwner(msg.sender);
        }

        _;
    }

    modifier nonReentrant() {
        if (locked) {
            revert ReentrancyDetected();
        }

        locked = true;
        _;
        locked = false;
    }

    ////////////////////////////////////////////////////////////////////////////
    // EXTERNAL FUNCTIONS                                                     //
    ////////////////////////////////////////////////////////////////////////////

    function plan(Call[] calldata calls_) external onlyOwner {
        updateCalls(calls_);
    }

    function prepare(uint256 deadline_) external onlyOwner {
        if (deadline_ < block.timestamp) {
            revert InvalidDeadline(deadline_);
        }

        updateDeadline(deadline_);
    }

    function execute() external nonReentrant {
        uint256 callCount = calls.length;
        uint256 deadline_ = deadline;

        if (callCount == 0) {
            revert CallsNotSet();
        }

        if (deadline_ == 0) {
            revert DeadlineNotSet();
        }

        if (block.timestamp < deadline_) {
            revert DeadlineNotReached(deadline_);
        }

        for (uint256 i = 0; i < callCount; ++i) {
            Call memory call = calls[i];

            (bool success, bytes memory returnData) = call.target.call(
                call.callData
            );

            emit CallExecuted(call.target, call.callData, success, returnData);
        }

        cleanupCalls();
        updateDeadline(0);
    }

    ////////////////////////////////////////////////////////////////////////////
    // INTERNAL FUNCTIONS                                                     //
    ////////////////////////////////////////////////////////////////////////////

    function updateCalls(Call[] calldata calls_) internal {
        calls = calls_;

        emit CallsUpdated(calls_);
    }

    function cleanupCalls() internal {
        delete calls;

        emit CallsUpdated(new Call[](0));
    }

    function updateDeadline(uint256 deadline_) internal {
        deadline = deadline_;

        emit DeadlineUpdated(deadline_);
    }

}
