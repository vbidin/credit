// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ICrypt {

    ////////////////////////////////////////////////////////////////////////////
    // TYPES                                                                  //
    ////////////////////////////////////////////////////////////////////////////

    /// @notice Stores the information needed to perform an external call.
    /// @dev    Calldata contains the function signature and encoded arguments.
    /// @param  target   Address to call into.
    /// @param  callData Calldata to perform the call with.
    struct Call {
        address target;
        bytes callData;
    }

    ////////////////////////////////////////////////////////////////////////////
    // EVENTS                                                                 //
    ////////////////////////////////////////////////////////////////////////////

    /// @notice Emitted when the crypt is initialized.
    /// @param  initializer Address of the initializer.
    /// @param  owner       Address of the crypt owner.
    event Initialized(address indexed initializer, address indexed owner);

    /// @notice Emitted when the activity deadline is updated.
    /// @param  deadline Timestamp of the new activity deadline.
    ///                  Value of `0` indicates deadline is not set.
    event DeadlineUpdated(uint256 deadline);

    /// @notice Emitted when the execution calls are updated.
    /// @param  calls Array of external calls to be performed on execution.
    ///               Empty array indicates calls are not set.
    event CallsUpdated(Call[] calls);

    /// @notice Emitted when a call is performed during execution.
    /// @param  target     Address that has been called.
    /// @param  callData   Calldata passed to the target.
    /// @param  success    Flag indicating if the call succeeded.
    /// @param  returnData Return value of the call.
    event CallExecuted(
        address indexed target,
        bytes callData,
        bool success,
        bytes returnData
    );

    ////////////////////////////////////////////////////////////////////////////
    // ERRORS                                                                 //
    ////////////////////////////////////////////////////////////////////////////

    /// @notice Reverts when the crypt has already been initialized.
    error AlreadyInitialized();

    /// @notice Reverts when the execution is performed before the deadline.
    /// @param  deadline Timestamp of the activity deadline.
    error DeadlineNotReached(uint256 deadline);

    /// @notice Reverts when execution is performed without deadline being set.
    error DeadlineNotSet();

    /// @notice Reverts when an invalid deadline has been set.
    /// @param  deadline Timestamp of the activity deadline.
    error InvalidDeadline(uint256 deadline);

    /// @notice Reverts when execution is performed without calls being set.
    error CallsNotSet();

    /// @notice Reverts when a guarded function is called by non-owner.
    error NotOwner(address caller);

    /// @notice Reverts when a reentrancy is detected during execution.
    error ReentrancyDetected();

    ////////////////////////////////////////////////////////////////////////////
    // MUTATING FUNCTIONS                                                     //
    ////////////////////////////////////////////////////////////////////////////

    function initialize(address owner) external;

    ////////////////////////////////////////////////////////////////////////////
    // VIEW FUNCTIONS                                                         //
    ////////////////////////////////////////////////////////////////////////////

    function owner() external view returns (address owner);

}
