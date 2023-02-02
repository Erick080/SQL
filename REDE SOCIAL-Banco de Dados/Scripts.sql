-------------------------------------
-- Banco de dados - EXTRA-CLASSE   --
-- Prof. Rodrigo Espindola         --
-- Davi Kolodzeiczak Iasculski     --
-- Eduardo Enes Traunig            --
-- Erick Branquinho Machado        --
-- Gabriel Rocha de Almeida        --
-------------------------------------

DROP TABLE tipoPerfil       CASCADE CONSTRAINTS;
DROP TABLE perfis           CASCADE CONSTRAINTS;
DROP TABLE conversas        CASCADE CONSTRAINTS;
DROP TABLE posts            CASCADE CONSTRAINTS;
DROP TABLE comentarios      CASCADE CONSTRAINTS;
DROP TABLE notificacoes     CASCADE CONSTRAINTS;
DROP TABLE respostas        CASCADE CONSTRAINTS;
DROP TABLE anuncios         CASCADE CONSTRAINTS;

CREATE TABLE perfis (
    nome                    VARCHAR2(100)   NOT NULL,
    username                VARCHAR2(100)   NOT NULL,
    data_criacao            DATE            NOT NULL,
    telefone                NUMBER(11)      NOT NULL,
    email                   VARCHAR2(100)   NOT NULL,
    senha                   VARCHAR2(100)   NOT NULL,
    seguindo                NUMBER(6)       NOT NULL,
    seguidores              NUMBER(6)       NOT NULL,
    num_publicacoes         NUMBER(6)       NOT NULL,
    CONSTRAINT pk_perfis PRIMARY KEY (username),
    CONSTRAINT uk_email UNIQUE (email)
);

CREATE TABLE tipoPerfil (
    cod_tipo_perfil         char(10)     NOT NULL,
    descricao               VARCHAR2(100)   NOT NULL,
    username                VARCHAR2(100)   NOT NULL,
    CONSTRAINT fk_username FOREIGN KEY (username) REFERENCES perfis (username),
    CONSTRAINT pk_tipoPerfil PRIMARY KEY (cod_tipo_perfil)
);

CREATE TABLE posts (
    username                VARCHAR2(100)   NOT NULL,
    data_post               DATE            NOT NULL,
    conteudo                VARCHAR2(100)   NOT NULL,
    qtd_curtidas            NUMBER(6)       NOT NULL,
    qtd_comentarios         NUMBER(6)       NOT NULL,
    qtd_compartilhamentos   NUMBER(6)       NOT NULL,
    CONSTRAINT fk_username_posts FOREIGN KEY (username) REFERENCES perfis (username),
    CONSTRAINT pk_posts PRIMARY KEY (username, data_post)
);

CREATE TABLE anuncios (
    username                VARCHAR2(100)   NOT NULL,
    data_post               DATE    NOT NULL,
    link_produto            VARCHAR2(100)   NOT NULL,
    CONSTRAINT fk_post_ad FOREIGN KEY (username, data_post) REFERENCES posts (username, data_post),
    CONSTRAINT pk_anuncios PRIMARY KEY (link_produto)
);

CREATE TABLE conversas (
    username_remetente      VARCHAR2(100)   NOT NULL,
    username_destinatario   VARCHAR2(100)   NOT NULL,
    qtd_mensagens           NUMBER(6)       NOT NULL,
    conteudo                VARCHAR2(100)   NOT NULL,
    CONSTRAINT fk_username_remetente FOREIGN KEY (username_remetente) REFERENCES perfis (username),
    CONSTRAINT fk_username_destinatario FOREIGN KEY (username_destinatario) REFERENCES perfis (username),
    CONSTRAINT pk_conversas PRIMARY KEY (username_remetente, username_destinatario)
);

CREATE TABLE comentarios (
    username_post           VARCHAR2(100)   NOT NULL,
    data_post               DATE            NOT NULL,
    comentador              VARCHAR2(100)   NOT NULL,
    conteudo                VARCHAR2(100)   NOT NULL,
    data_coment             DATE            NOT NULL,
    qtd_curtidas            NUMBER(6)       NOT NULL,
    qtd_respostas           NUMBER(6)       NOT NULL,
    CONSTRAINT fk_username_coment FOREIGN KEY (comentador) REFERENCES perfis (username),
    CONSTRAINT fk_post_coment FOREIGN KEY (username_post, data_post) REFERENCES posts (username, data_post),
    CONSTRAINT pk_comentarios PRIMARY KEY (comentador, data_coment)
);

CREATE TABLE notificacoes (
    username_post           VARCHAR2(100)   NOT NULL,
    data_post               DATE            NOT NULL,
    comentador              VARCHAR2(100)   NOT NULL,
    data_coment             DATE            NOT NULL,
    quantidade              NUMBER(6)       NOT NULL,
    CONSTRAINT fk_coment_notif FOREIGN KEY (comentador, data_coment) REFERENCES comentarios (comentador, data_coment),
    CONSTRAINT fk_post_notif FOREIGN KEY (username_post, data_post) REFERENCES posts (username, data_post),
    CONSTRAINT pk_notificacoes PRIMARY KEY (username_post, data_post, comentador, data_coment)
);

CREATE TABLE respostas (
    comentador_original         VARCHAR2(100)   NOT NULL,
    comentador_resposta         VARCHAR2(100)   NOT NULL,
    conteudo                    VARCHAR2(100)   NOT NULL,
    data_original               DATE            NOT NULL,
    data_resposta               DATE            NOT NULL,
    CONSTRAINT fk_coment_original FOREIGN KEY (comentador_original, data_original) REFERENCES comentarios (comentador, data_coment),
    CONSTRAINT fk_coment_resposta FOREIGN KEY (comentador_resposta, data_resposta) REFERENCES comentarios (comentador, data_coment),
    CONSTRAINT pk_respostas PRIMARY KEY (comentador_original, comentador_resposta, data_original, data_resposta)
);


-------------------------------------
-- Banco de dados - EXTRA-CLASSE   --
-- Prof. Rodrigo Espindola         --
-- Davi Kolodzeiczak Iasculski     --
-- Eduardo Enes Traunig            --
-- Erick Branquinho Machado        --
-- Gabriel Rocha de Almeida        --
-------------------------------------


-- perfis
INSERT INTO perfis (nome, username, data_criacao, telefone, email, senha, seguindo, seguidores, num_publicacoes) 
       VALUES      ('Olavo de Carvalho','olavinho20carvalho', '12-DEZ-1990', 51981631476, 'olavinhodecarvalho33@pucmail.com.br', 'asenhaehsenha', 3, 120, 5); --ano = (yyyy-mm-dd)
INSERT INTO perfis (nome, username, data_criacao, telefone, email, senha, seguindo, seguidores, num_publicacoes) 
       VALUES      ('Joana da Medeiros','joaninha40medeiros','12-JAN-1991', 51946131764, 'medeiros.joaninha@pucmail.com.br', 'coxinha123', 4, 582, 3); --ano = (yyyy-mm-dd)

-- tipo de perfil
INSERT INTO tipoPerfil (cod_tipo_perfil, descricao, username)
       VALUES      (0,'padrao','olavinho20carvalho');
       
-- posts
INSERT INTO posts (username, data_post, conteudo, qtd_curtidas, qtd_comentarios, qtd_compartilhamentos) 
       VALUES      ('olavinho20carvalho', '13-DEZ-1990','Trabalho de banco de dados', 29, 1, 8);
     
-- anuncios
INSERT INTO anuncios (username, data_post, link_produto)
       VALUES          ('olavinho20carvalho', '13-DEZ-1990', 'https://img.quizur.com/f/img628d6d0a788733.61164317.png?lastEdited=1653435671');
       
-- conversas
INSERT INTO conversas (username_remetente, username_destinatario, qtd_mensagens, conteudo)
       VALUES          ('olavinho20carvalho', 'joaninha40medeiros', 52, 'Oi... Oi... Meu nome é Olavinho de Carvalho, vamos ser amigues');
       
-- comentarios
INSERT INTO comentarios (username_post, data_post, comentador, conteudo, data_coment, qtd_curtidas, qtd_respostas)
       VALUES          ('olavinho20carvalho', '13-DEZ-1990', 'olavinho20carvalho', 'Magnifico, eu adorei', '13-JAN-1991', 1, 1);
INSERT INTO comentarios (username_post, data_post, comentador, conteudo, data_coment, qtd_curtidas, qtd_respostas)
       VALUES          ('olavinho20carvalho', '13-DEZ-1990', 'joaninha40medeiros', 'Muito Belo', '15-JAN-1991', 1, 1);
       
-- notificacoes
INSERT INTO notificacoes (username_post, data_post, comentador, data_coment, quantidade)
       VALUES          ('olavinho20carvalho', '13-DEZ-1990', 'olavinho20carvalho', '13-JAN-1991', 1);

-- respostas
INSERT INTO respostas (comentador_original, comentador_resposta, conteudo, data_original, data_resposta)
       VALUES       ('olavinho20carvalho', 'joaninha40medeiros', 'Muito Belo', '13-JAN-1991', '15-JAN-1991');

COMMIT;