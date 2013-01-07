mixin template ProtocolBuffer(string protocol) {
	string handle(string proto) {
		return proto;
	}
	mixin(handle(protocol));
}


mixin ProtocolBuffer!q{
struct X {
	int a,b;
}
};

void main() {
	X x;
}