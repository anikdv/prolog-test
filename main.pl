:- [knowledgeDB].

ownsCar(Name, Phone, Car, CarPrice, Owner):-
    Owner = carOwner(Name, Phone, Car, CarPrice),
    person(Name),
    hasPhone(Name, Phone),
    hasCar(Name, Car, CarPrice).

%   call: ?- carOwnerHasPhone(500600, R).
% result: R = [carOwner(ivanov, 500600, audi, 100500), carOwner(ivanov, 500600, bmw, 500100)].
carOwnerHasPhone(Phone, CarOwners):-
    findall(Owner, ownsCar(_, Phone, _, _, Owner), CarOwners).

carsMarks([],[]).
carsMarks([Owner], ResultCar):-
    Owner = carOwner(_, _, Car, _),
    ResultCar = [Car].
carsMarks([Owner|OtherOwners], ResultCars):-
    Owner = carOwner(_, _, Car, _),
    carsMarks(OtherOwners, OtherCars),
    ResultCars = [Car|OtherCars].

%   call: ?- carBelongsToPhone(500600, R).
% result: R = [audi, bmw] .
carBelongsToPhone(Phone, Cars):-
    carOwnerHasPhone(Phone, CarOwners),
    carsMarks(CarOwners, Cars).

personInfoIs(Name, City, Info):-
    Info = personInfo(Name, Phone, City, Street, Bank),
    person(Name),
    hasPhone(Name, Phone),
    hasAddress(Name, City, Street, _, _),
    hasBankAccount(Name, Bank, _).

%   call: ?- personsInfosAre(ivanov, moscow, Infos).
% result: Infos = [personInfo(ivanov, 500600, moscow, lenina, sber), personInfo(ivanov, 500600, moscow, lenina, alpha)].
personsInfosAre(Name, City, Infos):-
    findall(Info, personInfoIs(Name, City, Info), Infos).
