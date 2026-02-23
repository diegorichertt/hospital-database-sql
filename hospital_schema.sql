-- =====================================================
-- BANCO DE DADOS HOSPITALAR
-- Modelagem relacional para controle de pacientes,
-- médicos, consultas e tratamentos
-- PostgreSQL
-- =====================================================


-- =====================================================
-- CRIAÇÃO DAS TABELAS
-- =====================================================


-- ============================
-- TABELA: ESPECIALIDADES
-- ============================
CREATE TABLE especialidades (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);


-- ============================
-- TABELA: MEDICOS
-- ============================
CREATE TABLE medicos (
    id SERIAL PRIMARY KEY,
    nome_completo VARCHAR(150) NOT NULL,
    telefone VARCHAR(20),
    especialidade_id INT NOT NULL,

    FOREIGN KEY (especialidade_id)
        REFERENCES especialidades(id)
);


-- ============================
-- TABELA: PACIENTES
-- ============================
CREATE TABLE pacientes (
    id SERIAL PRIMARY KEY,
    nome_completo VARCHAR(150) NOT NULL,
    data_nascimento DATE NOT NULL,
    genero VARCHAR(20),
    telefone VARCHAR(20),
    endereco TEXT
);


-- ============================
-- TABELA: CONSULTAS
-- ============================
CREATE TABLE consultas (
    id SERIAL PRIMARY KEY,
    paciente_id INT NOT NULL,
    medico_id INT NOT NULL,
    data_consulta TIMESTAMP NOT NULL,
    observacoes TEXT,
    tipo_atendimento VARCHAR(50),

    FOREIGN KEY (paciente_id)
        REFERENCES pacientes(id),

    FOREIGN KEY (medico_id)
        REFERENCES medicos(id)
);


-- ============================
-- TABELA: TRATAMENTOS
-- ============================
CREATE TABLE tratamentos (
    id SERIAL PRIMARY KEY,
    consulta_id INT NOT NULL,
    medicamentos TEXT,
    descricao TEXT,

    FOREIGN KEY (consulta_id)
        REFERENCES consultas(id)
);



-- =====================================================
-- DADOS DE EXEMPLO (PARA TESTES)
-- =====================================================


-- ============================
-- ESPECIALIDADES
-- ============================
INSERT INTO especialidades (nome) VALUES
('Cardiologia'),
('Ortopedia'),
('Dermatologia'),
('Clínico Geral'),
('Neurologia');


-- ============================
-- MEDICOS
-- ============================
INSERT INTO medicos (nome_completo, telefone, especialidade_id) VALUES
('Dr. João Silva', '48999990001', 1),
('Dra. Mariana Costa', '48999990002', 2),
('Dr. Pedro Almeida', '48999990003', 3),
('Dra. Fernanda Rocha', '48999990004', 4),
('Dr. Lucas Martins', '48999990005', 5);


-- ============================
-- PACIENTES
-- ============================
INSERT INTO pacientes (nome_completo, data_nascimento, genero, telefone, endereco) VALUES
('Diego Henrique Richertt', '1996-03-26', 'Masculino', '48999990010', 'Florianópolis - SC'),
('Carlos Eduardo Souza', '1988-07-12', 'Masculino', '48999990011', 'São José - SC'),
('Ana Paula Fernandes', '1992-11-03', 'Feminino', '48999990012', 'Palhoça - SC'),
('Juliana Ribeiro', '2001-05-19', 'Feminino', '48999990013', 'Florianópolis - SC'),
('Marcos Vinicius Lima', '1979-09-25', 'Masculino', '48999990014', 'Biguaçu - SC');


-- ============================
-- CONSULTAS
-- ============================
INSERT INTO consultas (paciente_id, medico_id, data_consulta, observacoes, tipo_atendimento) VALUES
(1, 1, '2026-02-20 15:30:00', 'Avaliação cardíaca de rotina', 'Particular'),
(2, 2, '2026-02-21 10:00:00', 'Dor no joelho após corrida', 'Plano de saúde'),
(3, 3, '2026-02-22 14:00:00', 'Irritação na pele', 'Particular'),
(1, 4, '2026-02-22 16:30:00', 'Consulta clínica geral', 'Plano de saúde'),
(4, 1, '2026-02-23 09:00:00', 'Check-up cardíaco', 'Particular'),
(5, 5, '2026-02-23 11:00:00', 'Dores de cabeça frequentes', 'Plano de saúde');


-- ============================
-- TRATAMENTOS
-- ============================
INSERT INTO tratamentos (consulta_id, medicamentos, descricao) VALUES
(1, 'Atenolol 25mg', 'Tomar 1 comprimido ao dia por 30 dias'),
(2, 'Ibuprofeno 600mg', 'Tomar após refeições por 7 dias'),
(3, 'Pomada dermatológica', 'Aplicar 2 vezes ao dia por 10 dias'),
(4, 'Vitaminas e repouso', 'Manter hidratação e descanso'),
(5, 'Exames complementares', 'Realizar exames cardiológicos'),
(6, 'Analgésico', 'Uso em caso de dor');



-- =====================================================
-- CONSULTAS SQL DO PROJETO
-- =====================================================


-- 1) Pacientes com suas consultas e médicos
SELECT
    pacientes.nome_completo AS paciente,
    consultas.data_consulta,
    consultas.tipo_atendimento,
    medicos.nome_completo AS medico
FROM pacientes
JOIN consultas ON pacientes.id = consultas.paciente_id
JOIN medicos ON consultas.medico_id = medicos.id;


-- 2) Consultas de um médico específico
SELECT
    medicos.nome_completo AS medico,
    pacientes.nome_completo AS paciente,
    consultas.data_consulta,
    consultas.observacoes,
    consultas.tipo_atendimento
FROM consultas
JOIN medicos ON consultas.medico_id = medicos.id
JOIN pacientes ON consultas.paciente_id = pacientes.id
WHERE medicos.nome_completo = 'Dr. João Silva';


-- 3) Tratamentos com informações de paciente e médico
SELECT
    pacientes.nome_completo AS paciente,
    medicos.nome_completo AS medico,
    consultas.data_consulta,
    tratamentos.medicamentos,
    tratamentos.descricao
FROM tratamentos
JOIN consultas ON tratamentos.consulta_id = consultas.id
JOIN pacientes ON consultas.paciente_id = pacientes.id
JOIN medicos ON consultas.medico_id = medicos.id;


-- 4) Médicos com suas especialidades
SELECT
    medicos.nome_completo,
    medicos.telefone,
    especialidades.nome AS especialidade
FROM medicos
JOIN especialidades ON medicos.especialidade_id = especialidades.id;


-- 5) Consultas em uma data específica
SELECT
    consultas.data_consulta,
    pacientes.nome_completo AS paciente,
    medicos.nome_completo AS medico
FROM consultas
JOIN pacientes ON consultas.paciente_id = pacientes.id
JOIN medicos ON consultas.medico_id = medicos.id
WHERE DATE(consultas.data_consulta) = '2026-02-23';


-- 6) Pacientes atendidos por especialidade específica
SELECT DISTINCT
    pacientes.nome_completo,
    especialidades.nome AS especialidade
FROM pacientes
JOIN consultas ON pacientes.id = consultas.paciente_id
JOIN medicos ON consultas.medico_id = medicos.id
JOIN especialidades ON medicos.especialidade_id = especialidades.id
WHERE especialidades.nome = 'Cardiologia';


-- 7) Tratamentos de um paciente específico
SELECT
    pacientes.nome_completo,
    medicos.nome_completo AS medico,
    consultas.data_consulta,
    tratamentos.medicamentos,
    tratamentos.descricao
FROM tratamentos
JOIN consultas ON tratamentos.consulta_id = consultas.id
JOIN pacientes ON consultas.paciente_id = pacientes.id
JOIN medicos ON consultas.medico_id = medicos.id
WHERE pacientes.nome_completo = 'Diego Henrique Richertt';

