// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0;

interface IGhovidentFund {
    function supply(address assets, address spender, uint256 amount) external;

    function withdraw(
        address assets,
        address receiver,
        uint256 amount
    ) external;
}
