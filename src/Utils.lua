--  工具类
cc.exports.Utils = class("Utils")

function Utils:bufToInt32(num1, num2, num3, num4)
	local num = 0;
	num = num + self:leftShift(num1, 24);
	num = num + self:leftShift(num2, 16);
	num = num + self:leftShift(num3, 8);
	num = num + num4;
	return num;
end

function Utils:int32ToBufStr(num)
	local str = "";
	str = str .. self:numToAscii(self:rightShift(num, 24));
	str = str .. self:numToAscii(self:rightShift(num, 16));
	str = str .. self:numToAscii(self:rightShift(num, 8));
	str = str .. self:numToAscii(num);
	return str;
end

function Utils:bufToInt16(num1, num2)
	local num = 0;
	num = num + self:leftShift(num1, 8);
	num = num + num2;
	return num;
end

function Utils:int16ToBufStr(num)
	local str = "";
	str = str .. self:numToAscii(self:rightShift(num, 8));
	str = str .. self:numToAscii(num);
	return str;
end

function Utils:leftShift(num, shift)
	return math.floor(num * (2 ^ shift));
end

function Utils:rightShift(num, shift)
	return math.floor(num/(2^shift));
end

function Utils:numToAscii(num)
	num = num % 256;
	return string.char(num);
end