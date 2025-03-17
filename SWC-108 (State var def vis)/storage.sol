// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract TestStorage {
    uint storeduint1 = 15;
    uint constant constuint = 16;
    uint32 investmentDeadlineTimeStamp = uint32(block.timestamp);

    bytes16 string1 = "test1";
    bytes32 private string2 = "test1222";
    string public string3 = "Typing some text here...";

    mapping (address => uint) public uints1;
    mapping (address => DeviceData) structs1;

    uint[] uintArray;
    DeviceData[] deviceDataArray;

    struct DeviceData{
        string deviceBrand;
        string deviceYear;
        string BatteryWearLevel;
    }

    function testStorage() public {
        address address1 = 0xaee905FdD3ED851e48d22059575b9F4245A82B04;

        uints1[address1] = 88;

        DeviceData memory dev1 = DeviceData("deviceBrand", "deviceYear", "wearLevel");

        structs1[address1] = dev1;

        uintArray.push(1000);
        uintArray.push(2000);   

        deviceDataArray.push(dev1);
    }

}