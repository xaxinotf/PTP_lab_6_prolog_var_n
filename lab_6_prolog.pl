% database
car(nissan_leaf, electric, small, hatchback, 2019, 150, front).
car(nissan_qashqai, petrol, medium, suv, 2021, 190, all).
car(nissan_altima, petrol, medium, sedan, 2020, 180, front).
car(nissan_xterra, diesel, large, suv, 2018, 210, all).
car(nissan_juke, petrol, small, hatchback, 2019, 160, front).
car(nissan_maxima, petrol, large, sedan, 2020, 300, front).
car(nissan_murano, diesel, large, suv, 2021, 250, all).
car(nissan_note, electric, small, hatchback, 2022, 130, front).

% q
ask(Question, Options, Answer) :-
    writeln(Question),
    (Options = [] -> read(Answer)  % якщо немає заздалегідь визначених опцій, читаємо відповідь
    ; (member(Option, Options), format('~w ', [Option]), fail; nl, read(Answer))),  % показує опції та читає відповідь
    (Options = [] -> true; member(Answer, Options); Answer = 'xz').

% ідентифікація автомобіля з урахуванням усіх параметрів
identify_car :-
    ask('What is the power source?', [petrol, diesel, electric, 'xz'], Power),
    ask('What is the size?', [small, medium, large, 'xz'], Size),
    ask('What is the body type?', [sedan, hatchback, suv, 'xz'], BodyType),
    ask('What is the year of manufacture?', [], Year),
    ask('What is the horsepower?', [], Horsepower),
    ask('What is the drive type?', [front, all, 'xz'], DriveType),
    findall(Name, car(Name, Power, Size, BodyType, Year, Horsepower, DriveType), Matches),
    (Matches = [] -> writeln('No car matches those criteria.')
    ; writeln('Matching cars:'), print_matches(Matches)).

print_matches([]).
print_matches([Name|T]) :-
    car(Name, Power, Size, BodyType, Year, Horsepower, DriveType),
    format('~w: ~w, ~w, ~w, year ~w, ~w HP, drive: ~w~n', [Name, Power, Size, BodyType, Year, Horsepower, DriveType]),
    print_matches(T).

% main
run :-
    repeat,
    identify_car,
    ask('Do you want to continue? (yes/no)', [yes, no], Continue),
    Continue = no, !.
