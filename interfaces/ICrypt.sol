// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ICrypt {

    ////////////////////////////////////////////////////////////////////////////
    // TYPES                                                                  //
    ////////////////////////////////////////////////////////////////////////////

    struct Call {
        address target;
        bytes callData;
    }

    ////////////////////////////////////////////////////////////////////////////
    // EVENTS                                                                 //
    ////////////////////////////////////////////////////////////////////////////

    event Initialized(address indexed factory, address indexed owner);

    event DeadlineUpdated(uint256 deadline);

    event CallsUpdated(Call[] calls);

    event CallExecuted(
        address indexed target,
        bytes callData,
        bool success,
        bytes returnData
    );

    ////////////////////////////////////////////////////////////////////////////
    // ERRORS                                                                 //
    ////////////////////////////////////////////////////////////////////////////

    error AlreadyInitialized();

    error DeadlineNotReached(uint256 deadline);

    error DeadlineNotSet();

    error InvalidDeadline(uint256 deadline);

    error CallsNotSet();

    error NotOwner(address caller);

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
