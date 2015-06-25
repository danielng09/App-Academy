// cat class
function Cat(name, owner) {
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function () {
    console.log("Everyone loves " + this.name);
};
Cat.prototype.meow = function () {
    console.log("MEEEWOOOOWW!");
};

var gizmo = new Cat("gizmo", "Ned");
gizmo.meow = function () {
  console.log("meow...?!?");
};

var fluffy = new Cat("fluffy", "Ned");
console.log(gizmo.meow());
console.log(fluffy.meow());
