CREATE TABLE protegemed.versao(
	id integer not null auto_increment ,
	data datetime not null,
	id_versao varchar(20) not null,
    descricao varchar(100),
	constraint pk_versao_frequencia primary key(id)
);

insert into protegemed.versao(data, id_versao, descricao) values(now(), '1.0', 'Versão Rebonatto');

create table protegemed.periculosidade_fuga(
    id integer not null auto_increment,
    tipo char(1) not null,
    descricao varchar(50) not null,
    constraint pk_periculosidade_fuga primary key(id)
);

insert into protegemed.periculosidade_fuga(tipo, descricao) values('N', 'NORMAL');
insert into protegemed.periculosidade_fuga(tipo, descricao) values('A', 'ATENCAO');
insert into protegemed.periculosidade_fuga(tipo, descricao) values('P', 'PERIGO');

CREATE TABLE protegemed.escala_corrente(
    valor decimal(6, 5) not null,
	id_tipo integer not null,
    id_versao integer not null,
    constraint pk_correntes primary key(valor, id_versao),
    constraint fk_versao foreign key(id_versao) references versao(id),
    constraint fk_tipo_corrente foreign key(id_tipo) references periculosidade_fuga(id)
);

insert into protegemed.escala_corrente(valor,id_tipo,id_versao) values(0.06, 1, 1);
insert into protegemed.escala_corrente(valor,id_tipo,id_versao) values(0.1, 2, 1);
insert into protegemed.escala_corrente(valor,id_tipo,id_versao) values(0.5, 3, 1);

CREATE TABLE protegemed.escala_frequencia(
	id_tipo integer not null,
    id_versao integer not null,
    valor decimal(6, 5) not null,
    frequencia int not null,
    constraint pk_frequencias primary key(valor, frequencia, id_versao),
    constraint fk_versao_frequencia foreign key(id_versao) references versao(id),
    constraint fk_tipo_frequencia foreign key(id_tipo) references periculosidade_fuga(id)
);

insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(1,1,0.06000,60);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(1,1,0.06100,120);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(1,1,0.06400,180);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(1,1,0.06800,240);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(1,1,0.07300,300);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(1,1,0.07800,360);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(1,1,0.08300,420);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(1,1,0.08800,480);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(1,1,0.09300,540);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(1,1,0.09900,600);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(2,1,0.10000,60);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(2,1,0.10280,120);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(1,1,0.10300,660);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(2,1,0.10570,180);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(1,1,0.10700,720);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(2,1,0.11040,240);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(2,1,0.11580,300);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(2,1,0.12480,360);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(2,1,0.12600,420);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(2,1,0.13110,480);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(2,1,0.13590,540);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(2,1,0.14000,600);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(2,1,0.14460,660);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(2,1,0.14860,720);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(3,1,0.50000,60);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(3,1,0.79190,120);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(3,1,1.07810,180);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(3,1,1.56910,240);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(3,1,2.33680,300);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(3,1,2.63700,360);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(3,1,2.97460,420);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(3,1,3.33440,480);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(3,1,3.71100,540);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(3,1,4.08760,600);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(3,1,4.48930,660);
insert into protegemed.escala_frequencia(id_tipo, id_versao, valor, frequencia) values(3,1,4.90490,720);

CREATE TABLE protegemed.escala_similaridade(
	id_tipo integer not null,
    id_versao integer not null,
    valor_min decimal(6, 5) not null,
    valor_max decimal(6, 5) not null,
    constraint pk_periculosidade primary key(valor_min, valor_max, id_versao),
    constraint fk_versao_periculosidade foreign key(id_versao) references versao(id),
    constraint fk_tipo_periculosidade foreign key(id_tipo) references periculosidade_fuga(id)
);

insert into protegemed.escala_similaridade(id_tipo, id_versao, valor_min, valor_max) values(1, 1, 0.001, 0.849);
insert into protegemed.escala_similaridade(id_tipo, id_versao, valor_min, valor_max) values(2, 1, 0.850, 0.949);
insert into protegemed.escala_similaridade(id_tipo, id_versao, valor_min, valor_max) values(3, 1, 0.950, 1.000);

alter table protegemed.capturaatual add periculosidade_corrente int default 1;
alter table protegemed.capturaatual add periculosidade_frequencia int default 1;
alter table protegemed.capturaatual add periculosidade_similaridade int default 1;
alter table protegemed.capturaatual add constraint fk_periculosidade_corrente foreign key(periculosidade_corrente) references protegemed.periculosidade_fuga(id);
alter table protegemed.capturaatual add constraint fk_periculosidade_frequencia foreign key(periculosidade_frequencia) references protegemed.periculosidade_fuga(id);
alter table protegemed.capturaatual add constraint fk_periculosidade_similaridade foreign key(periculosidade_similaridade) references protegemed.periculosidade_fuga(id);
alter table protegemed.capturaatual modify dataatual datetime(6);
alter table protegemed.capturaatual add similaridade varchar(50);
alter table protegemed.capturaatual add spearman decimal(10, 6);

