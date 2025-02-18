import { expect } from "chai";
import { ethers } from "hardhat";
import { parseEther } from "ethers";

describe("SimpleBank", function () {
  let simpleBank;
  let owner;
  let addr1;

  beforeEach(async function () {
    const SimpleBank = await ethers.getContractFactory("SimpleBank");
    simpleBank = await SimpleBank.deploy();
    [owner, addr1] = await ethers.getSigners();
  });

  it("should deposit funds", async function () {
    const depositAmount = parseEther("1.0");
    
    await expect(simpleBank.connect(addr1).deposit({ value: depositAmount }))
      .to.emit(simpleBank, "Deposited")
      .withArgs(addr1.address, depositAmount);

    expect(await simpleBank.balances(addr1.address)).to.equal(depositAmount);
  });
});