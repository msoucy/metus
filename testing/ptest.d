#!/usr/bin/rdmd

import metus.dproto.dproto;
import std.conv;
import std.stdio;

mixin ProtocolBuffer!"point.proto";

auto printBytes(ubyte[] data)
{
	"%(%02X %)".writefln(data);
	return data;
}

void main() {
	static if(1) {
		auto p1 = Point();
		if(p1.x.exists) {
			int tmp = p1.x;
		} else {
			p1.x = 5;
		}
		p1.x.clean();
		p1.x.writeln();
		p1.label = "testing";
		p1.serialize().printBytes();
		auto p2 = Point(p1.serialize());
		"%s".writefln(p2);
	}
	static if(1) {
		auto t2 = Test2();
		t2.b = "testing";
		t2.serialize().printBytes();
	}
	static if(1) {
		auto t3 = Test3();
		t3.c.a = 150;
		t3.serialize().printBytes();
	}
	static if(1) {
		auto c1 = Point.Coord();
		c1.writeln();
		c1.serialize().printBytes();
	}
	static if(1) {
		auto t4 = Test4();
		t4.d = [3, 270, 86942];
		t4.serialize().printBytes();
	}
}
