import {
  time,
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("GhovidentFactory", function () {
  const poolName = "Ghovident Fund";
  const assetToken = "0x88541670E55cC00bEEFD87eB59EDd1b7C511AC9a";
  const aavePoolAddress = "0x6Ae43d3271ff6888e7Fc43Fd7321a503ff738951";
  async function deployGhovidentFactoryFixture() {
    const [owner, otherAccount] = await ethers.getSigners();

    // Deploy GhovidentFund
    const GhovidentFund = await ethers.getContractFactory("GhovidentFund");
    const ghovidentFund = await GhovidentFund.deploy(aavePoolAddress);

    // Deploy GhovidentFactory
    const GhovidentFactory = await ethers.getContractFactory(
      "GhovidentFactory"
    );
    const ghovidentFactory = await GhovidentFactory.deploy();

    return { ghovidentFactory, ghovidentFund, owner, otherAccount };
  }

  describe("Create pool", async function () {
    it("Should pool created", async function () {
      const { ghovidentFactory, ghovidentFund, owner } = await loadFixture(
        deployGhovidentFactoryFixture
      );
      await ghovidentFactory.createPool(
        poolName,
        assetToken,
        "0x5FbDB2315678afecb367f032d93F642f64180aa3"
      );
      const pool = await ghovidentFactory.pools(0);
      const poolContract = await ethers.getContractAt("GhovidentPool", pool);
      const poolFactory = await poolContract.factory();
      expect(poolFactory).to.equal(await ghovidentFactory.getAddress());
      expect(await poolContract.name()).to.equal(poolName);
    });
  });
});
