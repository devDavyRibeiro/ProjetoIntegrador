create database SANEASP
use SANEASP

create table Usuarios
(
    id_usuario int not null identity (1,1) primary key,
    nome_usuario varchar(50) not null,
    telefone varchar(14),
    cidade varchar(30),
    bairro varchar(30),
    rua varchar(30),
    numero varchar(30),
    complemento varchar(30),
    cep char(8),
    email varchar(40) not null unique,
    senha varchar(100) not null,
    cpf char(11) unique
)

create table Administradores
(
    id_admin int not null identity (1,1) primary key,
    id_usuario int not null,
    nivel int not null
        Constraint FK_usuario_admin foreign key (id_usuario) references Usuarios(id_usuario)
)



create table Tabela_logs
(
    id_log int not null identity(1,1) primary key,
    operacao varchar(20) not null,
    data_log datetime not null default GETDATE(),
    conteudo_log varchar(255) not null,
    historico varchar(20) not null,
    id_usuario int not null
        Constraint FK_usuario_log foreign key (id_usuario) references Usuarios(id_usuario)
)



create table Doencas
(
    id_doenca int not null identity(1,1) primary key,
    nome_doenca varchar(60) not null,
    transmissao varchar(255) not null,
    tratamento varchar(255) not null,
    data_publicacao_doenca datetime default GETDATE() not null,
    id_admin int not null
        Constraint FK_admin_doenca foreign key (id_admin) references Administradores(id_admin)

)



create table Sintomas
(
    id_sintoma int not null identity(1,1) primary key,
    nome_sintoma varchar(50) not null
)



create table Sintomas_doenca
(
    id_sintoma_doenca int not null identity(1,1) primary key,
    id_doenca int not null,
    id_sintoma int not null,
    Constraint FK_doenca foreign key (id_doenca) references Doencas(id_doenca)
)



create table Reclamacoes
(
    id_reclamacao int not null identity(1,1) primary key,
    id_usuario int not null,
    titulo_reclamacao varchar(40) not null,
    descricao_reclamacao varchar(255) not null,
    endereco_reclamacao varchar(200) not null,
    status_reclamacao varchar(20) not null,
    data_reclamacao datetime default GETDATE() not null,
    pontuacao int not null
        Constraint FK_usuario_reclamacao foreign key (id_usuario) references Usuarios(id_usuario)
)



create table Comentarios
(
    id_comentario int not null identity(1,1) primary key,
    id_admin int,
    id_usuario int not null,
    id_reclamacao int not null,
    descricao_comentario varchar(255) not null,
    data_comentario datetime default GETDATE() not null,
    Constraint FK_comentario_administrador foreign key (id_admin) references Administradores(id_admin),
    Constraint FK_comentario_usuario foreign key (id_usuario) references Usuarios(id_usuario),
    Constraint FK_comentario_reclamacao foreign key (id_reclamacao) references Reclamacoes(id_reclamacao)
)



create table Imagens_reclamacao
(
    id_imagem_reclamacao int not null identity(1,1) primary key,
    imagem_reclamacao varchar(100) not null,
    id_reclamacao int not null
        Constraint FK_imagem_reclamacao foreign key (id_reclamacao) references Reclamacoes(id_reclamacao)
)



create table Tags
(
    id_tag int not null identity(1,1) primary key,
    nome_tag varchar(50) not null
)



create table Tags_reclamacao
(
    id_tag_reclamacao int not null identity(1,1) primary key,
    id_tag int not null,
    id_reclamacao int not null
        Constraint FK_tags_reclamacao_tag foreign key (id_tag) references Tags(id_tag),
        Constraint FK_tags_reclamacao_reclamacao foreign key (id_reclamacao) references Reclamacoes(id_reclamacao)
)



create table Noticias
(
    id_noticia int not null identity(1,1) primary key,
    titulo_noticia varchar(100) not null,
    descricao_noticia varchar(255),
    id_admin int not null,
    data_publicacao_noticia datetime default GETDATE() not null
        Constraint FK_noticia_administrador foreign key (id_admin) references Administradores(id_admin)

)



create table Imagens_noticia
(
    id_imagem_noticia int not null identity(1,1) primary key,
    imagem_noticia varchar(100) not null,
    id_noticia int not null
        Constraint FK_imagem_noticia foreign key (id_noticia) references Noticias(id_noticia)

)



create table Fontes_noticia
(
    id_fonte_noticia int not null identity(1,1) primary key,
    fonte_noticia varchar(255) not null,
    id_noticia int not null
        Constraint FK_fonte_noticia foreign key (id_noticia) references Noticias(id_noticia)
)



create table Tags_noticia
(
    id_tag_noticia int not null identity(1,1) primary key,
    id_tag int not null,
    id_noticia int not null
        Constraint FK_tags_noticia_tag foreign key (id_tag) references Tags(id_tag),
        Constraint FK_tags_noticia_noticia foreign key (id_noticia) references Noticias(id_noticia)
)



create table Imagens_doenca
(
    id_imagem_doenca int not null identity(1,1) primary key,
    imagem_doenca varchar(100) not null,
    id_doenca int not null
        Constraint FK_imagem_doenca foreign key (id_doenca) references Doencas(id_doenca)

)



create table Fontes_doenca
(
    id_fonte_doenca int not null identity(1,1) primary key,
    fonte_doenca varchar(255) not null,
    id_doenca int not null
        Constraint FK_fonte_doenca foreign key (id_doenca) references Doencas(id_doenca)
)



insert into Usuarios
    (nome_usuario, telefone, cep, cidade, bairro, complemento, rua, numero, email, senha, cpf)
values
    ('Davy Oliveira', '12345678910123', '18075718', 'Sorocaba', 'Wanel', 'Fundos', 'Alonco Muchon', '122', 'davy@gmail.com', '12345', '12345678910'),
    ('Adryann Theylor', '1098765432101', '57181807', 'Votorantim', 'Vossoroca', 'bloco A', 'Natal', '122', 'etec@etec.com', 'senhaconfiavel', '12310456789'),
    ('Matheus Gueff', '1076543210198', '51818077', 'Sorocaba', 'Jd Brasilândia', '', 'Alonco Muchon', '928', 'matheus@etec.com', 'senhanaoconfiavel', '10451236789'),
    ('Jones Terceiro Semestre', '1087654321019', '58180177', 'Itu', 'Bairro tal', 'Bloco B', 'Paes de Linhares', '18', 'jones@fatec.com', 'senha', '15123604789'),
    ('Jonin Alberto', '18910122345673', '18180775', 'Votorantim', 'Clarice', '', 'Alonco Muchon', '111', 'jonin@etec.com', '12345*', '45123610789'),
    ('Lavínia', '11111111111111', '11111111', 'Sorocaba', 'Mineirão', '', 'Ermolau del Cistia', '192', 'lav@etec.com', '**12345*', '42361510789'),
    ('Comum', '11111222211111', '22111111', 'Sorocaba', 'Mineirão', '', 'Ermolau del Cistia', '11', 'etequi@etec.com', '2345*', '15231046789')

-- Administrador 

INSERT INTO Administradores
    (id_usuario, nivel)
VALUES
    (1, 3),
    (2, 2),
    (3, 2),
    (4, 1),
    (5, 1)

-- Log 

INSERT INTO Tabela_logs
    (operacao, data_log, conteudo_log, historico, id_usuario)
VALUES
    ('ADIÇÃO', '2022-02-10 00:00:00.000', 'Achei um problema no meu encanamento, tem algumbixo la dentrueui', 'criação', 1),
    ('EDIÇÃO', '2022-28-10 00:00:00.000', 'Achei um problema no meu encanamento, tem algumbixo la dentrueui', 'antigo', 1),
    ('EDIÇÃO', '2024-28-10 00:00:00.000', 'Achei um problema no meu encanamento, tem algum bixo la dentro (apenas corrigindo)', 'novo', 1),
    ('ADIÇÃO', '2023-01-01 00:00:00.000', 'Estou com certo problema', 'criação', 6),
    ('EDIÇÃO', '2022-05-03 00:00:00.000', 'Estou com certo problema', 'antigo', 6),
    ('EDIÇÃO', '2022-05-03 00:00:00.000', 'Esqueci de mencionar o problema, é que minha água ta muito quente nesse calor, preciso de gelo urgentemente', 'novo', 6);

-- Doença 

INSERT INTO Doencas
    (nome_doenca, transmissao, tratamento, id_admin, data_publicacao_doenca)
VALUES
    ('Esquistossomose', 'Contaminação', 'Médico', 1, '2022-05-01 00:00:00.000'),
    ('Dengue', 'Picada', 'Beber água', 2, '2020-05-03 00:00:00.000'),
    ('Cólera', 'Infeccção', 'Descansar', 2, '2018-12-11 00:00:00.000'),
    ('Ascaridiase', 'Infeccção', 'Melhorar', 3, '2022-13-10 00:00:00.000'),
    ('Leptospirose', 'Infeccção', 'Tentar melhorar', 2, '2024-05-08 00:00:00.000')

-- Sintomas 

INSERT INTO Sintomas
    (nome_sintoma)
VALUES
    ('Febre'),
    ('Tosse'),
    ('Dor de cabeça'),
    ('Nausea'),
    ('Diarreia')

-- Sintomas_doenca 

INSERT INTO Sintomas_doenca
    (id_doenca, id_sintoma)
VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 4),
    (4, 5),
    (3, 4),
    (2, 2)

-- Reclamacoes 

INSERT INTO Reclamacoes
    (id_usuario, titulo_reclamacao, descricao_reclamacao, endereco_reclamacao, status_reclamacao, pontuacao, data_reclamacao)
VALUES
    (6, 'Minha rua ta ruim', 'Muitos buracos na rua', 'Rua tal 123 - Bairro tal', 'visualizada', 5, '2020-12-12 00:00:00.000'),
    (6, 'Vi que tem um problema aqui perto', 'Tem um problema acontecendo aqui no meu bairro', 'Rua tal 11 - Bairro tal', 'enviado', 4, '2022-10-05 00:00:00.000'),
    (6, 'Minha encanação EXPLODIU', 'Literalmente explodiu', 'Rua tal 95 - Bairro aquele la', 'enviado', 9, '2022-08-12 00:00:00.000'),
    (6, 'Vi uma contaminação na água aqui perto', 'Contaminarão minha água', 'Rua tal 1112 - Bairro tal', 'enviado', 1, '2023-31-01 00:00:00.000'),
    (7, 'DEU UM PROBLEMÃO', 'Nem eu sei oq é, só sei que é um grande problema, um PROBLEMÃO', 'Rua tal 24 - Bairro tal2', 'resolvida', 10, '2023-01-01 00:00:00.000')

-- Comentários 

INSERT INTO Comentarios
    (id_admin, id_usuario, id_reclamacao, descricao_comentario, data_comentario)
VALUES
    (2, 2, 5, 'Que problemão é esse? Seja mais específico', '2022-10-10 00:00:00.000'),
    (null, 7, 5, 'Mano, um problemão, tipo muito', '2022-11-10 00:00:00.000'),
    (2, 2, 5, 'Ta mas... que problema?', '2022-12-10 00:00:00.000'),
    (null, 7, 5, 'Um professor meu vai deixar de dar aula pra nós no próximo semestre', '2022-13-10 00:00:00.000'),
    (2, 2, 5, 'Poxa que triste sinto muito por você, mas tipo, aqui é só sobre reclamações de saneamento básico', '2022-14-10 00:00:00.000'),
    (null, 7, 5, 'Ata, desculpar só queria desabafar, obrigado pela sua ajuda!', '2022-20-10 00:00:00.000'),
    (1, 1, 1, 'Sua rua ta ruim é? Sinto muito por você', '2024-15-11 00:00:00.000')

-- Imagens_reclamacao 

INSERT INTO Imagens_reclamacao
    (imagem_reclamacao, id_reclamacao)
VALUES
    ('agua.jpg', 1),
    ('icone_problema.png', 2),
    ('explosao.jpg', 3),
    ('icone_contaminacao.png', 4),
    ('agua.jpg', 5),
    ('icone_problema_grande.jpg', 5)

-- Tags 

INSERT INTO Tags
    (nome_tag)
VALUES
    ('Vazamento'),
    ('Esgoto'),
    ('Água'),
    ('Saúde'),
    ('Obras'),
    ('Atendimento')

-- Tags_reclamacao 

INSERT INTO Tags_reclamacao
    (id_tag, id_reclamacao)
VALUES
    (1, 5),
    (2, 5),
    (3, 5),
    (6, 5),
    (4, 2)

-- Noticia 

INSERT INTO Noticias
    (titulo_noticia, descricao_noticia, id_admin, data_publicacao_noticia)
VALUES
    ('Corrigimos uma encanação', 'Deu tudo certo pessoal fiquem tranquilos', 1, '2022-08-10 00:00:00.000'),
    ('Dia Mundial da Água', 'Dia mundial da água estamos distribuindo água', 1, '2022-09-10 00:00:00.000'),
    ('Reclamação esquisita aparece no nosso site', 'Pessoal´, é urgente que entendam que esse site é apenas para reclamações sobre saneamento básico e não para desabafos', 3, '2022-12-12 00:00:00.000'),
    ('Bebam Água', 'Lembre-se de beber água', 2, '2022-15-12 00:00:00.000'),
    ('Se beber dirija!', 'Não se esqueçam de se hidratar, mesmo no trânsito! Só cuidado pra não bater (e sem bebidas alcoolicas, É PRA BEBER ÁGUA)', 4, '2024-20-11 00:00:00.000')

-- Imagem_noticia 

INSERT INTO Imagens_noticia
    (imagem_noticia, id_noticia)
VALUES
    ('WhatsApp Image 2024-10-14 at 18.39.24.jpg', 1),
    ('agua_feliz.jpg', 2),
    ('aviso.jpg', 3),
    ('bebendo_agua_icone.jpg', 4),
    ('sebebernaodirija-icone.jpg', 5)

-- Fontes_noticia 

INSERT INTO Fontes_noticia
    (fonte_noticia, id_noticia)
VALUES
    ('https://cruzeiro.rs.gov.br/noticia/visualizar/id/5250/?prefeitura-resolve-problema-provocado-por-encanamento-particular.html', 1),
    ('https://www.peixeboi.org.br/post/dia-mundial-da-%C3%A1gua', 2),
    ('https://www.infopedia.pt/dicionarios/lingua-portuguesa/aviso', 3),
    ('https://www.unimed.coop.br/viver-bem/saude-em-pauta/a-importancia-da-agua-no-corpo-humano-tire-todas-as-suas-duvidas', 4),
    ('https://www.tjdft.jus.br/institucional/imprensa/campanhas-e-produtos/direito-facil/edicao-semanal/se-beber-nao-dirija', 5)

-- Tag_noticia 

INSERT INTO Tags_noticia
    (id_tag, id_noticia)
VALUES
    (5, 2),
    (3, 1),
    (4, 3),
    (5, 4),
    (5, 5)

-- Imagens_noticia 

INSERT INTO Imagens_doenca
    (imagem_doenca, id_doenca)
VALUES
    ('esquistossomose.jpg', 1),
    ('mosquitao.jpg', 2),
    ('doenca.jpg', 3),
    ('icone_doenca.jpg', 4),
    ('bacteria.png', 5)

-- Fontes_doenca 

INSERT INTO Fontes_doenca
    (fonte_doenca, id_doenca)
VALUES
    ('https://blog.brkambiental.com.br/doencas-de-veiculacao-hidrica/', 1),
    ('https://www.gov.br/saude/pt-br/assuntos/saude-de-a-a-z/d/dengue/', 2),
    ('https://www.gov.br/saude/pt-br/assuntos/saude-de-a-a-z/c/colera', 3),
    ('https://www.rededorsaoluiz.com.br/doencas/ascaridiase', 4),
    ('https://www.gov.br/saude/pt-br/assuntos/saude-de-a-a-z/l/leptospirose', 5)

-- Select para todas as tabelas 

SELECT *
FROM Usuarios;

SELECT *
FROM Administradores;

SELECT *
FROM Tabela_logs;

SELECT *
FROM Doencas;

SELECT *
FROM Sintomas;

SELECT *
FROM Sintomas_doenca;

SELECT *
FROM Reclamacoes;

SELECT *
FROM Comentarios;

SELECT *
FROM Imagens_reclamacao;

SELECT *
FROM Tags;

SELECT *
FROM Tags_reclamacao;

SELECT *
FROM Noticias;

SELECT *
FROM Imagens_noticia;

SELECT *
FROM Fontes_noticia;

SELECT *
FROM Tags_noticia;

SELECT *
FROM Imagens_doenca;

SELECT *
FROM Fontes_doenca;



-- Mostrando administradores ordenados por nível (De 3 a 1) 

select *
from Administradores
order by nivel desc


-- Mostrando reclamações que não foram resolvidas ainda 

select *
from Reclamacoes
where status_reclamacao != 'resolvida'

-- Mostrando quantidade de usuários por bairro 


select bairro, count(*) as 'Quantidade por bairro'
from Usuarios
group by bairro

-- Mostrando quais tags tem a reclamação 


select r.titulo_reclamacao, string_agg(t.nome_tag, ', ') as 'Tags da reclamação'

from Reclamacoes r
    inner join Tags_reclamacao tg on tg.id_reclamacao = r.id_reclamacao
    inner join Tags t on t.id_tag = tg.id_tag
group by r.titulo_reclamacao;

-- Mostrando quais tags tem a notícia 


select n.titulo_noticia, string_agg(t.nome_tag, ', ') as 'Tags da Notícia'
from Noticias n
    inner join Tags_noticia tn on tn.id_noticia = n.id_noticia
    inner join Tags t on t.id_tag = tn.id_tag
group by n.titulo_noticia;

-- Mostrando todas informações da doença com as tabelas sintomas, imagens e fontes, separadas por vírgula 


select d.nome_doenca, string_agg(s.nome_sintoma, ', ') as 'Tags da Doença', string_agg(imd.imagem_doenca, ', ') as 'Fontes da Doença', string_agg(fd.fonte_doenca, ', ') as 'Fontes da Doença'

from Doencas d
    inner join Sintomas_doenca sd on d.id_doenca = sd.id_doenca
    inner join Sintomas s on sd.id_sintoma = s.id_sintoma
    inner join Fontes_doenca fd on fd.id_doenca = d.id_doenca
    inner join Imagens_doenca imd on imd.id_doenca = d.id_doenca
group by d.nome_doenca

-- Mostrando as 3 reclamãções com maior pontuação e que não tenham sido resolvidas 


select top 3 *
from Reclamacoes
where status_reclamacao != 'resolvida'
order by pontuacao desc; 