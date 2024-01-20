// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../interfaces/IGhovidentInvestment.sol";
import "../interfaces/IAavePool.sol";
import "../interfaces/IERC20WithPermit.sol";

contract GProvidentFund is IGhovidentInvestment {
    IAavePool aavePool;
    IERC20WithPermit public assetesToken;

    constructor(address _aavePool, address _assetesToken) {
        aavePool = IAavePool(_aavePool);
        assetesToken = IERC20WithPermit(_assetesToken);
    }

    function stake(address _pool, uint256 amount) external override {
        // assetesToken.transferFrom(
        //     _pool,
        //     address(0x00ced1b5E0D948dAD8039c5645492aa9447e0b66),
        //     amount
        // );
        // transfer from msg.sender to this contract
        // approve aave pool to spend the amount
        // call aave pool to supply
        // update totalStaked
        // update balances
        // assetesToken.approve(address(aavePool), amount);
        assetesToken.approve(address(aavePool), amount);
        aavePool.supply(address(assetesToken), amount, _pool, 0);
    }

    // withdraw

    function loan() external override {}

    function getBalanceAssetes() external view returns (uint) {
        return assetesToken.balanceOf(address(this));
    }

    receive() external payable {}
}
