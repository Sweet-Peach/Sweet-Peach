-- Igor Luiz Gomes de Souza
create database competicao;

-- Igor Luiz Gomes de Souza
use competicao;

-- Igor Luiz Gomes de Souza 
create table competicao(
	id_competicao int primary key auto_increment,
    cidade varchar(50),
    nome varchar (50)
);

create table proprietario (
	id_proprietario int primary key auto_increment,
    nome varchar(80),
    telefone varchar(15),
    email varchar(100),
    orientador int, 
    foreign key (orientador) references proprietario(id_proprietario)
);

-- Igor Luiz Gomes de Souza
create table cavalo (
	id_cavalo int auto_increment,
    nome varchar(50),
    raca varchar(50),
    nascimento date, 
    fk_proprietario int,
    primary key(id_cavalo),
    foreign key (fk_proprietario) references proprietario(id_proprietario)
);

create table competidor(
	fk_competicao int, fk_cavalo int, primary key(fk_competicao, fk_cavalo),
    posicao int,
    premio decimal(9,2),
    foreign key(fk_competicao) references competicao(id_competicao),
    foreign key(fk_cavalo) references cavalo(id_cavalo)
);

-- Igor Luiz Gomes de Souza
insert into proprietario values(null, "Carlos Andre Potrino", "1147897489", "carlos@carlos.com", null); -- proprietário mais experiente

insert into proprietario values(null, "Antonio Garcia Costa", "1149863782", "antonio@antonio.com", 1), -- proprietário novato
(null, "Andrezza Priorinni", "1147891526", "andrezza@andrezza.com", 1);-- proprietário novato

insert into competicao values (null, "Interlagos", "Copa Potranco"), (null, "Ferraz de Vasconcelos", "Racha Queima Ferradura"); -- competição

insert into cavalo values (null, "Corcel", "Premium", "2005-12-25", 1), (null, "Donzela", "Runner", "2004-06-21", 1), -- cavalos do Carlos
(null, "Clarice", "Premium", "2005-12-25", 2), -- Cavalo do Antonio
(null, "Arrancada", "Premium", "2005-12-25", 3); -- Cavalo da Andrezza

insert into competidor values (1, 1, 2, 500000.00), (1, 2, 1, 1000000.00), -- Competidores na Copa Potranco
(2, 1, 1, 500000.00), (2, 3, 3, 250000.00), (2, 4, 2, 500000.00); -- Competidores no Racha Queima Ferraduras


-- Igor Luiz Gomes de Souza
select * from proprietario;

-- Igor Luiz Gomes de Souza
select * from competicao;

-- Igor Luiz Gomes de Souza
select * from cavalo;

-- Igor Luiz Gomes de Souza
select * from competidor;

-- Igor Luiz Gomes de Souza
alter table cavalo add column nacionalidade varchar(50);

update cavalo set nacionalidade = "Brasileiro" where id_cavalo in (1,2);
update cavalo set nacionalidade = "Britânico" where id_cavalo = 3;
update cavalo set nacionalidade = "Espanhol" where id_cavalo = 4;

-- Igor Luiz Gomes de Souza
select id from cavalo as ca
join competidor as dor
	on dor.fk_cavalo = ca.id_cavalo
join competicao as cao 
	on dor.fk_competicao = cao.id_competicao;

-- Igor Luiz Gomes de Souza
select * from cavalo as ca
join competidor as dor
	on dor.fk_cavalo = ca.id_cavalo
join competicao as cao 
	on dor.fk_competicao = cao.id_competicao
where ca.nome = "Corcel";

-- Igor Luiz Gomes de Souza 
select * from proprietario as novato 
join proprietario as expe
	on novato.orientador = expe.id_proprietario;
    
-- Igor Luiz Gomes de Souza
select * from proprietario as novato 
join proprietario as expe
	on novato.orientador = expe.id_proprietario
where expe.nome = 'Carlos Andre Potrino';

-- Igor Luiz Gomes de Souza
select novato.nome, novato.telefone, novato.email, expe.nome, expe.telefone, expe.email, 
ca.nome, ca.raca, ca.nascimento, ca.nacionalidade, co.nome, co.cidade from proprietario as novato 
join cavalo as ca 
	on ca.fk_proprietario = novato.id_proprietario
join proprietario as expe
	on novato.orientador = expe.id_proprietario
join competidor
	on competidor.fk_cavalo = ca.id_cavalo
join competicao as co
	on competidor.fk_competicao = co.id_competicao;
    
-- Igor Luiz Gomes de Souza
select pro.nome as "Nome do proprietário", ca.nome as "Nome do cavalo", dor.posicao as colocação 
from competidor as dor
join cavalo as ca
	on dor.fk_cavalo = ca.id_cavalo
join proprietario as pro
	on ca.fk_proprietario = pro.id_proprietario
join competicao cao
	on dor.fk_competicao = cao.id_competicao
where cao.id_competicao = 2 order by dor.posicao;

-- Igor Luiz Gomes de Souza
select cao.nome as "nome da competição", ca.raca as "raça do cavalo", truncate(avg(dor.premio), 2) as "a média do valor da
premiação"
from competidor as dor
join cavalo as ca
	on dor.fk_cavalo = ca.id_cavalo
join proprietario as pro
	on ca.fk_proprietario = pro.id_proprietario
join competicao cao
	on dor.fk_competicao = cao.id_competicao
group by (cao.nome);


-- Igor Luiz Gomes de Souza
Insert into cavalo value (null, "Pé de Pano", "Cavalo Árabe", "2008-06-21", 3, "Árabe");

select ca.*, cao.* 
from cavalo as ca 
left join competidor as dor
	on dor.fk_cavalo = ca.id_cavalo
left join competicao cao
	on dor.fk_competicao = cao.id_competicao;



