import std.stdio;

abstract class I {
private:
	void bar() {
		"I::bar".writeln();
	}
protected:
	void baz() {
		"I::baz".writeln();
	}
public:
	void foo() {
		"I::foo".writeln();
		bar();
		baz();
	}
}

class A : I {
private:
	void bar() {
		"A::bar".writeln();
	}
protected:
	override void baz() {
		"A::baz".writeln();
	}
public:
	static if(0)
	override void foo() {
		"A::foo".writeln();
		bar();
		baz();
	}
}

void main() {
	I i = new A();
	i.foo();
}