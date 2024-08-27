// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ICrypt } from '@crypt/interfaces/ICrypt.sol';

// TODO: Rename to something else?
contract Crypt is ICrypt {

    ////////////////////////////////////////////////////////////////////////////
    // CONSTANTS                                                              //
    ////////////////////////////////////////////////////////////////////////////

    // TODO: Should this value be passed in during initialization?
    //       Could fetch it from the factory contract as well.
    address constant multicall = 0xcA11bde05977b3631167028862bE2a173976CA11;

    ////////////////////////////////////////////////////////////////////////////
    // STATE                                                                  //
    ////////////////////////////////////////////////////////////////////////////

    address public owner;

    // TODO: Rename `deadline` to something more intuitive.
    uint256 public deadline;

    // TODO: Optimize by replacing `bool` with `uint256`.
    bool initialized;
    bool locked;

    // TODO: Expose the array of calls publicly.
    Call[] calls;

    ////////////////////////////////////////////////////////////////////////////
    // INITIALIZATION                                                         //
    ////////////////////////////////////////////////////////////////////////////

    // TODO: Also pass in `calls`, `deadline`, and `permit()` signatures.
    //       This will allow for complete set up up with just ONE transaction.
    function initialize(address owner_) external notInitialized {
        owner = owner_;
        initialized = true;

        emit Initialized(msg.sender, owner);
    }

    ////////////////////////////////////////////////////////////////////////////
    // MODIFIERS                                                              //
    ////////////////////////////////////////////////////////////////////////////

    // TODO: Optimize initailization check.
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

    // TODO: Optimize reentrancy guard.
    modifier nonReentrant() {
        if (locked) {
            revert ReentrancyDetected();
        }

        locked = true;

        _;

        locked = false;
    }

    ////////////////////////////////////////////////////////////////////////////
    // MAIN FUNCTIONALITY                                                     //
    ////////////////////////////////////////////////////////////////////////////

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

        deleteCalls();
        updateDeadline(0);
    }

    ////////////////////////////////////////////////////////////////////////////
    // CONFIGURATION                                                          //
    ////////////////////////////////////////////////////////////////////////////

    function plan(Call[] calldata calls_) external onlyOwner {
        updateCalls(calls_);
    }

    function prepare(uint256 deadline_) external onlyOwner {
        updateDeadline(deadline_);
    }

    ////////////////////////////////////////////////////////////////////////////
    // INTERNALS                                                              //
    ////////////////////////////////////////////////////////////////////////////

    function deleteCalls() internal {
        delete calls;

        emit CallsUpdated(new Call[](0));
    }

    function updateCalls(Call[] calldata calls_) internal {
        calls = calls_;

        emit CallsUpdated(calls_);
    }

    function updateDeadline(uint256 deadline_) internal {
        if (deadline != 0 && deadline_ < block.timestamp) {
            revert InvalidDeadline(deadline_);
        }

        deadline = deadline_;

        emit DeadlineUpdated(deadline_);
    }

}
