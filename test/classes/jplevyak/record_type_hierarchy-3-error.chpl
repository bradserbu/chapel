record C {
  var x : int;
}

record D {
  var x : int;
  var y : int;
}

proc f(a : D) {
  return 1;
}

var b = new C();

writeln(f(b));
