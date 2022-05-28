// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title
/// @notice
/// @dev
interface ILineOfCredit {
    /// @notice Address of the ERC-20 token.
    /// @dev
    /// @return asset
    function asset() external view returns (address asset);

    /// @notice Address of the lender.
    /// @dev
    /// @return lender
    function lender() external view returns (uint lender);

    /// @notice Address of the borrower.
    /// @dev
    /// @return borrower
    function borrower() external view returns (address borrower);

    /// @notice The rate at which interest accumulates.
    /// @dev    The interest rate is annualized, one year is equivalent to 365 days for this purpose.
    ///         Should the interest rate be denominated per second instead?
    ///         How many decimals of precision should be used to represent the percentage?
    /// @return rate
    function rate() external view returns (uint rate);

    /// @notice Amount of assets owed by the borrower.
    /// @dev
    /// @return debt
    function debt() external view returns (uint debt);

    /// @notice Threshold of debt after which the lender can trigger a default.
    /// @dev
    /// @return threshold
    function threshold() external view returns (uint threshold);

    // TODO: Function that returns the amount of assets currently available to be borrowed.
    // TODO: Function for creating the line of credit. Borrower automatically accepts after borrowing for the first time.
    // TODO: Function for closing the line of credit. Both lender and borrower can close after all debt is repaid.
    //       Lender can also close if the credit is inactive or debt is above the threshold.
    // TODO: Functions for increasing and decreasing available credit, used by the lender.
    // TODO: Functions for borrowing and repaying, used by the borrower.
    // TODO: Add errors and events, as well as structs (if needed).
}
