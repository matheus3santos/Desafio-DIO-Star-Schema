CREATE TABLE Professor (
    idProfessor INT PRIMARY KEY,
    idDepartamento INT,
    FOREIGN KEY (idDepartamento) REFERENCES Departamento(idDepartamento)
);


CREATE TABLE Departamento (

    idDepartamento INT PRIMARY KEY,
    nome VARCHAR(45),
    campus VARCHAR(45),
    idProfessorCoordenador INT
    /*FOREIGN KEY (idProfessorCoordenador) REFERENCES Professor(idProfessor)*/
);

ALTER TABLE Departamento
ADD CONSTRAINT fk_coordenador FOREIGN KEY (idProfessorCoordenador)
REFERENCES Professor(idProfessor);

CREATE TABLE Disciplina (
    idDisciplina INT PRIMARY KEY,
    idProfessor INT,
    FOREIGN KEY (idProfessor) REFERENCES Professor(idProfessor)
);

CREATE TABLE Curso (
    idCurso INT PRIMARY KEY,
    idDepartamento INT,
    FOREIGN KEY (idDepartamento) REFERENCES Departamento(idDepartamento)
);

CREATE TABLE DisciplinaCurso (
    idDisciplina INT,
    idCurso INT,
    PRIMARY KEY (idDisciplina, idCurso),
    FOREIGN KEY (idDisciplina) REFERENCES Disciplina(idDisciplina),
    FOREIGN KEY (idCurso) REFERENCES Curso(idCurso)
);

CREATE TABLE Aluno (
    idAluno INT PRIMARY KEY,
    idCurso INT,
    FOREIGN KEY (idCurso) REFERENCES Curso(idCurso)
);

CREATE TABLE Matriculado (
    idAluno INT,
    idDisciplina INT,
    PRIMARY KEY (idAluno, idDisciplina),
    FOREIGN KEY (idAluno) REFERENCES Aluno(idAluno),
    FOREIGN KEY (idDisciplina) REFERENCES Disciplina(idDisciplina)
);

CREATE TABLE Pre_requisito (
    idPreRequisito INT PRIMARY KEY
);

CREATE TABLE Pre_requisito_disciplina (
    idDisciplina INT,
    idPreRequisito INT,
    PRIMARY KEY (idDisciplina, idPreRequisito),
    FOREIGN KEY (idDisciplina) REFERENCES Disciplina(idDisciplina),
    FOREIGN KEY (idPreRequisito) REFERENCES Pre_requisito(idPreRequisito)
);


CREATE TABLE Dimensao_Professor (
    idProfessor INT PRIMARY KEY,     -- Chave primária, usada para ligar à tabela fato
    nomeProfessor VARCHAR(100),      -- Nome do professor
    titulo VARCHAR(50),              -- Título acadêmico (ex: Doutor, Mestre)
    idade INT,                       -- Idade do professor
    tempoNaInstituicao INT,          -- Tempo que o professor trabalha na instituição (anos)
    idDepartamento INT              -- Chave estrangeira para a dimensão departamento
    /*FOREIGN KEY (idDepartamento) REFERENCES Dimensao_Departamento(idDepartamento)*/
);

ALTER TABLE Dimensao_Professor
ADD CONSTRAINT fk_departamento FOREIGN KEY (idDepartamento) 
REFERENCES Dimensao_Departamento(idDepartamento);


CREATE TABLE Fato_Professor (
    idFatoProfessor INT PRIMARY KEY,      -- Chave primária da tabela fato
    idProfessor INT,                      -- Chave estrangeira para a dimensão professor
    idCurso INT,                          -- Chave estrangeira para a dimensão curso
    idDisciplina INT,                     -- Chave estrangeira para a dimensão disciplina
    idDepartamento INT,                   -- Chave estrangeira para a dimensão departamento
    idData INT,                           -- Chave estrangeira para a dimensão de datas
    
    -- Métricas (valores quantitativos a serem analisados)
    horasMinistradas INT,                 -- Quantidade de horas ministradas por um professor
    numeroDisciplinas INT,                -- Número de disciplinas ministradas
    salarioProfessor DECIMAL(10, 2),      -- Salário do professor
    
    FOREIGN KEY (idProfessor) REFERENCES Dimensao_Professor(idProfessor),
    FOREIGN KEY (idCurso) REFERENCES Dimensao_Curso(idCurso),
    FOREIGN KEY (idDisciplina) REFERENCES Dimensao_Disciplina(idDisciplina),
    FOREIGN KEY (idDepartamento) REFERENCES Dimensao_Departamento(idDepartamento),
    FOREIGN KEY (idData) REFERENCES Dimensao_Data(idData)
);

CREATE TABLE Dimensao_Data (
    idData INT PRIMARY KEY,             -- Chave primária (ID da data)
    data DATE,                          -- Data (no formato yyyy-mm-dd)
    dia INT,                            -- Dia do mês
    mes INT,                            -- Mês
    ano INT,                            -- Ano
    trimestre INT                       -- Trimestre
);

CREATE TABLE Dimensao_Curso (
    idCurso INT PRIMARY KEY,            -- Chave primária
    nomeCurso VARCHAR(100),             -- Nome do curso
    nivelCurso VARCHAR(50),             -- Nível do curso (ex: Graduação, Mestrado, Doutorado)
    idDepartamento INT,                 -- Departamento responsável pelo curso (chave estrangeira)
    FOREIGN KEY (idDepartamento) REFERENCES Dimensao_Departamento(idDepartamento)
);

CREATE TABLE Dimensao_Departamento (
    idDepartamento INT PRIMARY KEY,     -- Chave primária
    nomeDepartamento VARCHAR(100),      -- Nome do departamento
    campus VARCHAR(100),                -- Campus ao qual o departamento pertence
    idProfessorCoordenador INT,         -- Coordenador do departamento (chave estrangeira para professor)
    FOREIGN KEY (idProfessorCoordenador) REFERENCES Dimensao_Professor(idProfessor)
);

CREATE TABLE Dimensao_Disciplina (
    idDisciplina INT PRIMARY KEY,      -- Chave primária
    nomeDisciplina VARCHAR(100),       -- Nome da disciplina
    idProfessor INT,                   -- Professor que ministra a disciplina (chave estrangeira)
    FOREIGN KEY (idProfessor) REFERENCES Dimensao_Professor(idProfessor)
);










