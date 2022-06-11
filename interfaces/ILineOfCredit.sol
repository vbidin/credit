// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ILineOfCredit {
    /***************/
    /*** Structs ***/
    /***************/

    /**************/
    /*** Events ***/
    /**************/

    /**************/
    /*** Errors ***/
    /**************/

    /********************************/
    /*** State-Changing Functions ***/
    /********************************/

    // Adjustment of available credit is done through the use of the `approve()` function.

    /**********************/
    /*** View Functions ***/
    /**********************/

    /// @notice Returns the address of the contract that represents the underlying asset.
    /// @dev    The contract must be ERC-20 compatible.
    ///         Total supply of the ERC-20 token must not be too large to cause overflows when multiplied by the interest rate.
    /// @return asset Address of the asset contract.
    function asset() external view returns (address asset);

    /// @notice Returns the address of the creditor.
    /// @dev    The creditor can be an EOA or a contract.
    /// @return creditor Address of the creditor.
    function creditor() external view returns (uint creditor);

    /// @notice Returns the address of the debtor.
    /// @dev    The debtor can be an EOA or a contract.
    /// @return debtor Address of the debtor.
    function debtor() external view returns (address debtor);

    /// @notice Returns the interest rate at which debt compounds.
    /// @dev    The interest rate is annualized, one year is equivalent to 365 days for this purpose.
    ///         How many decimals of precision should be used to represent the percentage?
    ///         Should the interest rate be denominated per second instead?
    /// @return interestRate The interest rate.
    function interestRate() external view returns (uint interestRate);

    /// @notice Returns the amount of assets currently available for borrowing.
    /// @dev    This amount can not be greater than the amount of assets deposited into the contract by the creditor.
    ///         Assets that are transferred directly to this contract belong to neither creditor or debtor.
    /// @return credit Amount of assets available for borrowing.
    function credit() external view returns (uint credit);

    /// @notice Returns the amount of assets owed by the debtor as of the current time.
    /// @dev    Includes the oustanding principal plus all accumulated interest.
    /// @return debt Amount of assets owed by the debtor.
    function debt() external view returns (uint debt);
}
