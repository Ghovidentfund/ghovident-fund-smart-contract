// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./interfaces/IERC20WithPermit.sol";
import "./interfaces/IGhovidentFund.sol";
import "./interfaces/IGhovidentPool.sol";
import "./interfaces/IGhovidentFactory.sol";

contract GhovidentPool is IGhovidentPool {
    address public immutable factory;

    string public name;
    string public logoUri;
    string public factSheetUri;
    uint256 public risk; // 1 = low, 2 = monderate, 3 = high , 4 = very high
    uint256 public period; // 0 = 1M, 1 = 3M, 2 = 6M, 3 = 12M
    address public assets; // address of token
    address public fund;

    IERC20WithPermit private _token;
    IGhovidentFactory private _ghovidentFactory;

    uint256 public totalVolume;

    mapping(address => uint256) public volumeOf; // volume of each company

    constructor(
        address _factory,
        string memory _name,
        string memory _logoUri,
        string memory _factSheetUri,
        uint256 _risk,
        uint256 _period,
        address _assets,
        address _fund
    ) {
        factory = _factory;
        name = _name;
        logoUri = _logoUri;
        factSheetUri = _factSheetUri;
        risk = _risk;
        period = _period;
        assets = _assets;
        fund = _fund;

        _token = IERC20WithPermit(_assets);
        _ghovidentFactory = IGhovidentFactory(_factory);
    }

    function buy(uint256 amount) public {
        _token.transferFrom(msg.sender, address(this), amount);
        totalVolume += amount;
        volumeOf[msg.sender] += amount;
        _ghovidentFactory.investIn(msg.sender, address(this));
        supply();
    }

    function withdraw(uint256 amount) public {
        require(amount <= volumeOf[msg.sender], "Not enough balance");
        _token.transfer(msg.sender, amount);
        totalVolume -= amount;
        volumeOf[msg.sender] -= amount;
    }

    function claim() public {}

    function supply() internal {
        // Call Fund to supply
    }

    function getPoolInfo(
        address _company
    ) external view override returns (PoolInfo memory) {
        return
            PoolInfo(
                name,
                logoUri,
                factSheetUri,
                risk,
                period,
                assets,
                fund,
                totalVolume,
                volumeOf[_company]
            );
    }
}
