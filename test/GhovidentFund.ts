import {
  time,
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("GhovidentFund", function () {
  const aaveTokenAddress = "0x88541670E55cC00bEEFD87eB59EDd1b7C511AC9a";
  const aavePoolAddress = "0x6Ae43d3271ff6888e7Fc43Fd7321a503ff738951";
  async function deployGhovidentFundFixture() {
    // const [owner, otherAccount] = await ethers.getSigners();
    const mainWallet = new ethers.Wallet(
      "db9eb784e9bc174822742d585714c37ad6445af0439e3cc1d241147b318e4c4a"
    );
    const GhovidentFund = await ethers.getContractFactory("GhovidentFund");
    const ghovidentFund = await GhovidentFund.connect(mainWallet).deploy(
      aavePoolAddress
    );

    return { ghovidentFund };
  }

  describe("SupplyWithPermit", async function () {
    it("Should supply with permit", async function () {
      //   const { ghovidentFund } = await loadFixture(deployGhovidentFundFixture);
      const mainWallet = new ethers.Wallet(
        "db9eb784e9bc174822742d585714c37ad6445af0439e3cc1d241147b318e4c4a"
      );
      const GhovidentFund = await ethers.getContractFactory("GhovidentFund");
      const ghovidentFund = await GhovidentFund.deploy(aavePoolAddress);
      const deadline = (await time.latest()) + 1000;
      const signature = await mainWallet.signTypedData(
        {
          name: "Ghovident",
          version: "4",
          chainId: 31337,
          verifyingContract: aaveTokenAddress,
        },
        {
          Permit: [
            { name: "owner", type: "address" },
            { name: "spender", type: "address" },
            { name: "value", type: "uint256" },
            { name: "nonce", type: "uint256" },
            { name: "deadline", type: "uint256" },
          ],
        },
        {
          owner: await ghovidentFund.getAddress(),
          spender: aavePoolAddress,
          value: ethers.parseEther("5"),
          nonce: 0,
          deadline: deadline,
        }
      );
      const { v, r, s } = ethers.Signature.from(signature);
      //   await ghovidentFund.supplyWithPermit(
      //     aaveTokenAddress,
      //     ethers.parseEther("5"),
      //     mainWallet.address,
      //     0,
      //     deadline,
      //     v,
      //     r,
      //     s
      //   );
    });
  });
});
