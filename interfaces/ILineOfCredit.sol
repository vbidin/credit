// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title
/// @notice
/// @dev
interface ILineOfCredit {
    // TODO: Add errors and events, as well as structs? (if needed).

    /// @notice Returns the address of the contract that represents the underlying asset.
    /// @dev    The contract must be ERC-20 compatible.
    ///         Total supply of the ERC-20 token must not be too large to cause overflows when multiplied by the interest rate.
    /// @return asset The contract address.
    function asset() external view returns (address asset);

    /// @notice Returns the address of the lender.
    /// @dev    The lender can be an EOA or a contract.
    /// @return lender The lender address.
    function lender() external view returns (uint lender);

    /// @notice Returns the address of the borrower.
    /// @dev    The borrower can be an EOA or a contract.
    /// @return borrower The borrower address.
    function borrower() external view returns (address borrower);

    /// @notice Returns the interest rate at which debt compounds.
    /// @dev    The interest rate is annualized, one year is equivalent to 365 days for this purpose.
    ///         How many decimals of precision should be used to represent the percentage?
    ///         Should the interest rate be denominated per second instead?
    /// @return interestRate The interest rate.
    function interestRate() external view returns (uint interestRate);

    /// @notice Returns the amount of assets currently available for borrowing.
    /// @dev    This amount can not be greater than the amount of assets deposited into the contract by the lender.
    ///         Assets that are transferred directly to this contract belong to neither lender or borrower.
    /// @return credit Amount of assets available for borrowing.
    function credit() external view returns (uint credit);

    /// @notice Returns the amount of assets owed by the borrower as of the current time.
    /// @dev    Includes the oustanding principal plus all accumulated interest.
    /// @return debt Amount of assets owed by the borrower.
    function debt() external view returns (uint debt);

    /// @notice Returns the maximum debt after which a default can be triggered.
    /// @dev    This value can be a constant threshold or can be calculated dynamically.
    ///         Return `type(uint).max` if the debt ceiling does not exist.
    /// @return debtCeiling The debt ceiling.
    function debtCeiling() external view returns (uint debtCeiling);

    // TODO: Functions for increasing and decreasing available credit, used by the lender.
    // TODO: Function for adjusting the debt ceiling (through what kind of mechanisms?).
    // TODO: Functions for borrowing and repaying, used by the borrower.
    // TODO: Function for closing the line of credit. Both lender and borrower can close after all debt is repaid.
    //       Lender can also close if the line of credit is inactive or the debt is above the default threshold.
    // TODO: Function that allows the borrower to adjust the interest rate (gradually over time, never retroactively).
    // TODO: Functions that allow the borrower and lender addresses to be updated via a handshake.
    // TODO: Functions that allow for collateral to be posted (initially and on demand) in order to increase the debt ceiling.
    // TODO: Function for retrieving unaccounted assets accidentally sent to the contract (send to lost and found, or treasury?).
    // TODO: Keep track of statistics of each lender / borrower (better use The Graph for this).
    // TODO: Add separate contract where all assets of borrower can be stored, with allowances on a per borrower basis?
}
