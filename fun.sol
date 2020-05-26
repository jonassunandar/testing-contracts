pragma solidity 0.6.3;

contract fun {
    uint public a;
    bytes32 public testByte32;
    bytes12 public id;
    address public addrTest;
    
    function func() view public returns(uint256){
        return a;
    }
    
    function getTime() pure public returns(uint256){
        return 1 days;
    }
    
    function stringToBytes32(string memory source) public pure returns (bytes32 result) {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }
    
        assembly {
            result := mload(add(source, 32))
        }
    }
    
    
    function stringToBytes(string memory source) public returns (bytes memory result) {
        bytes memory tempEmptyStringTest = bytes(source);
        result = tempEmptyStringTest;
        // if (tempEmptyStringTest.length == 0) {
        //     return 0x0;
        // }
    
        // assembly {
        //     result := mload(add(source, 32))
        // }
    }
    
    function stringToUint(string memory str) public view returns(uint){
        uint res = 0;
        bytes memory byteString = bytes(str);
        uint len = byteString.length;
        uint i = 0;
        while(i!=len){
            uint8 temp = uint8(byteString[i]);
            res = res*10 + (temp-48);
            i++;
        }
        return res;
    }
    
    function uintToBytesCharacter(uint8 num) public view returns(string memory res){
        bytes memory bytesArray = new bytes(1);
        bytesArray[0] = byte(num);
        res = string(bytesArray);
        return res;
    }
    
    function print0ToZ() public view returns(string memory res){
        bytes memory bytess;
        for(uint8 i=48;i<=57;i++){
            bytes memory tempBytes = new bytes(1);
            tempBytes[0] = byte(i);
            bytess = abi.encodePacked(bytess, tempBytes);
        }
        
        for(uint8 i=65;i<=90;i++){
            bytes memory tempBytes = new bytes(1);
            tempBytes[0] = byte(i);
            bytess = abi.encodePacked(bytess, tempBytes);
        }
        res = string(bytess);
    }
    
    function bytesToAddress (bytes memory b)public returns (address) {
        uint result = 0;
        for (uint i = 0; i < b.length; i++) {
            uint c = uint(uint8(b[i]));
            if (c >= 48 && c <= 57) {
                result = result * 16 + (c - 48);
            }
            if(c >= 65 && c<= 90) {
                result = result * 16 + (c - 55);
            }
            if(c >= 97 && c<= 122) {
                result = result * 16 + (c - 87);
            }
        }
        return address(result);
    }
    address public wuauw;
    function parseAddr(string memory _a) public returns (address){
        bytes memory byt32 = stringToBytes(_a);
        address b = bytesToAddress(byt32);
        wuauw = b;
        return b;
    }

    mapping(bytes32=>bool) test;
    event fucker(bool wtf);
    function getTest(bytes32 _a) public returns (bool){
        emit fucker(test[_a]);
        return test[_a];    
    }
    
    function getBytes(address addr) public pure returns(bytes32){
        bytes memory aa = abi.encodePacked(addr, bytes12("revertable"));
        return bytesToBytes32(aa,0);
    }
    
    function bytesToBytes32(bytes memory b, uint offset) private pure returns (bytes32) {
      bytes32 out;
    
      for (uint i = 0; i < 32; i++) {
        out |= bytes32(b[offset + i] & 0xFF) >> (i * 8);
      }
      return out;
    }
    
    function set(uint256 _a) public{
        a = _a;
    }
    
    function divide(uint c, uint b) public pure returns(uint){
        return c/b;
    }
    
    function getFunc() public view returns(uint256){
        return func();
    }
    
    function to32(bytes32 testByte) public returns(bytes32){
        (address Addr , bytes12 _id) = parseId(testByte);
        id = _id;
        addrTest = Addr;
        testByte32 = bytes32(_id);
        return testByte32;
    }
    
    function to32Test(bytes32 testByte) view public returns(bytes32){
        (address Addr , bytes12 _id) = parseId(testByte);
        return bytesToBytes32(abi.encodePacked(Addr, bytes12(0)),0);
    }
    
    function parseId(bytes32 _id) public pure returns (address addr, bytes12 version) {
        bytes32 mask12 = 0xffffffffffffffffffffffff0000000000000000000000000000000000000000;
        bytes32 mask20 = 0xffffffffffffffffffffffffffffffffffffffff000000000000000000000000;

        addr = address(bytes20(_id&mask20));
        version = bytes12((_id<<(20)*8)&mask12);
    }
    
    
    function get0ToZ() public view returns(string memory res){
        bytes memory bytess;
        for(uint8 i=48;i<=57;i++){ //characters '0' to '9'  are 48-57 in ascii.
            bytes memory tempBytes = new bytes(1);
            tempBytes[0] = byte(i);
            bytess = abi.encodePacked(bytess, tempBytes);
        }
        
        for(uint8 i=65;i<=90;i++){ //characters 'A' to 'Z'  are 65-90 in ascii.
            bytes memory tempBytes = new bytes(1);
            tempBytes[0] = byte(i);
            bytess = abi.encodePacked(bytess, tempBytes);
        }
        res = string(bytess);
    }
    //https://stackoverflow.com/questions/48600347/how-to-reverse-a-string-in-solidity
    function reverseString(string memory _base) public returns(string memory){
        bytes memory _baseBytes = bytes(_base);
        assert(_baseBytes.length > 0);

        string memory _tempValue = new string(_baseBytes.length);
        bytes memory _newValue = bytes(_tempValue);


        for(uint i=0;i<_baseBytes.length;i++){
            _newValue[ _baseBytes.length - i - 1] = _baseBytes[i];
        }

        return string(_newValue);
    }
    
    //source https://ethereum.stackexchange.com/questions/6591/conversion-of-uint-to-string
    function uintToBytes(uint v) pure public returns (bytes32 ret) {
        if (v == 0) {
            ret = '0';
        }
        else {
            while (v > 0) {
                ret = bytes32(uint(ret) / (2 ** 8));
                ret |= bytes32(((v % 10) + 48) * 2 ** (8 * 31));
                v /= 10;
            }
        }
        return ret;
    }
    
    function bytes32ToString(bytes32 x) public returns (string memory) {
        bytes memory bytesString = new bytes(32);
        uint charCount = 0;
        for (uint j = 0; j < 32; j++) {
            byte char = byte(bytes32(uint(x) * 2 ** (8 * j)));
            if (char != 0) {
                bytesString[charCount] = char;
                charCount++;
            }
        }
        bytes memory bytesStringTrimmed = new bytes(charCount);
        for (uint8 j = 0; j < charCount; j++) {
            bytesStringTrimmed[j] = bytesString[j];
        }
        return string(bytesStringTrimmed);
    }
    
    function bytesToBytes12(bytes memory b) public pure returns (bytes12) {
        bytes12 out;
        uint256 length = b.length;
        for (uint i = 0; i < length; i++) {
            out |= bytes12(b[i] & 0xFF) >> (i * 8);
        }
        return out;
    }
    
    //source: https://gist.github.com/raineorshine/9af4524c0be4c83f641e80d9d9df20d9
    /// @dev Does a byte-by-byte lexicographical comparison of two strings.
    /// @return a negative number if `_a` is smaller, zero if they are equal
    /// and a positive numbe if `_b` is smaller.
    function compareString(string memory _a, string memory _b) public returns (int) {
        bytes memory a = bytes(_a);
        bytes memory b = bytes(_b);
        uint minLength = a.length;
        if (b.length < minLength) minLength = b.length;
        //@todo unroll the loop into increments of 32 and do full 32 byte comparisons
        for (uint i = 0; i < minLength; i ++)
            if (a[i] < b[i])
                return -1;
            else if (a[i] > b[i])
                return 1;
        if (a.length < b.length)
            return -1;
        else if (a.length > b.length)
            return 1;
        else
            return 0;
    }
}