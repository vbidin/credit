// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title  Defines a factory contract that creates crypts.
/// @notice Creates proxies that redirect to an implementation of a crypt.
/// @dev    MUST NOT create upgradeable proxies.
///         MUST create fully transparent proxies.
interface ICryptFactory {

    ////////////////////////////////////////////////////////////////////////////
    // EVENTS                                                                 //
    ////////////////////////////////////////////////////////////////////////////

    /// @notice Emitted when a `crypt` is created on behalf of `owner`.
    /// @param  crypt Address of the crypt proxy.
    /// @param  owner Address of the owner of the crypt.
    event CryptCreated(address indexed crypt, address indexed owner);

    ////////////////////////////////////////////////////////////////////////////
    // ERRORS                                                                 //
    ////////////////////////////////////////////////////////////////////////////

    /// @notice Reverts when a `crypt` already exists.
    /// @param  crypt Address of the existing crypt.
    error CryptExists(address crypt);

    ////////////////////////////////////////////////////////////////////////////
    // MUTATING FUNCTIONS                                                     //
    ////////////////////////////////////////////////////////////////////////////

    /// @notice Creates a new `crypt` owned by the `owner`.
    /// @dev    CAN be called by an address other than the `owner`.
    ///         MUST revert if the `owner` already owns an existing crypt.
    /// @param  owner Address of the crypt owner.
    /// @return crypt Address of the crypt proxy.
    function create(address owner) external returns (address crypt);

    ////////////////////////////////////////////////////////////////////////////
    // VIEW FUNCTIONS                                                         //
    ////////////////////////////////////////////////////////////////////////////

    /// @notice Returns the address of the crypt owned by `owner`.
    /// @dev    MUST return `address(0)` if `owner` has no crypt.
    /// @param  owner Address of the crypt owner.
    /// @return crypt Address of the crypt proxy.
    function cryptOf(address owner) external returns (address crypt);

    /// @notice Returns the address of the crypt implementation.
    /// @dev    MUST be used as the implementation of all crypt proxies.
    ///         MUST be immutable.
    /// @return implementation Address of the crypt implementation contract.
    function implementation() external view returns (address implementation);

}
