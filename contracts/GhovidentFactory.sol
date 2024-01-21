// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./GhovidentPool.sol";

contract GhovidentFactory {
    address[] public pools;

    event PoolCreated(address pool, address owner);

    function createPool(
        string memory _name,
        address _assetToken,
        address _ghovidentFund
    ) external {
        // TODO: validate assetToken and ghovidentFund is same address
        address pool = address(
            new GhovidentPool(address(this), _name, _assetToken, _ghovidentFund)
        );
        pools.push(pool);
        emit PoolCreated(pool, msg.sender);
    }
}
