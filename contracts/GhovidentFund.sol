// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./GhovidentPool.sol";
import "./interfaces/IAavePool.sol";

contract GhovidentFund {
    IAavePool public aavePool;

    constructor(address _aavePool) {
        aavePool = IAavePool(_aavePool);
    }

    function supply(
        address asset,
        uint256 amount,
        address onBehalfOf,
        uint16 referralCode
    ) public {
        aavePool.supply(asset, amount, onBehalfOf, referralCode);
    }

    function supplyWithPermit(
        address asset,
        uint256 amount,
        address onBehalfOf,
        uint16 referralCode,
        uint256 deadline,
        uint8 permitV,
        bytes32 permitR,
        bytes32 permitS
    ) public {
        aavePool.supplyWithPermit(
            asset,
            amount,
            onBehalfOf,
            referralCode,
            deadline,
            permitV,
            permitR,
            permitS
        );
    }
}
