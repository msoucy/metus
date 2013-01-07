import std.stdio;
import std.algorithm;

@safe pure string parseProto(string s) {
	return `struct Foo {
		void run() {
			writeln("`~s~`");
		}
	}`;
}

mixin template ProtocolBuffer(string protocol) {
	static if(protocol.endsWith(".proto")) {
		mixin ProtocolBuffer!(import(protocol));
	} else {
		mixin(parseProto(protocol));
	}
}

//mixin ProtocolBuffer!"a.proto";
mixin ProtocolBuffer!"Not a Proto File";

void main() {
	auto x = Foo();
	x.run();
}