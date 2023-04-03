CREATE TABLE Empresa_parceira( 

  CNPJ INTEGER  PRIMARY KEY, 

  Nome VARCHAR(50), 

  Endereco VARCHAR(50) 

); 
CREATE TABLE TECNOLOGIA( 

  IDTecnologia INTEGER PRIMARY KEY, 

  Nome VARCHAR(50), 

  Area VARCHAR(50) 

); 
CREATE TABLE RELATORIO( 
CNPJ INT,
idrelatorio INTEGER PRIMARY KEY, 

Data_Compilacao DATE
	
);
ALTER TABLE relatorio
ADD CONSTRAINT fk_cnpj
FOREIGN KEY (cnpj) 
REFERENCES empresa_parceira(cnpj)


CREATE TABLE nome_curso( 

  ID_Curso INTEGER PRIMARY KEY, 

  Nome VARCHAR(50), 

  CargaHoraria INTEGER, 

  Turno VARCHAR(50), 

  Stack VARCHAR(50), 

  CNPJ INTEGER NOT NULL 
);

ALTER TABLE nome_curso

ADD CONSTRAINT fk_cnpj 

FOREIGN KEY (cnpj) 

REFERENCES empresa_parceira(cnpj); 

CREATE TABLE Relatorio_tec( 

IDRelatorio INTEGER NOT NULL, 

IDtecnologia INTEGER NOT NULL, 

CONSTRAINT pk_Relatorio_tec PRIMARY KEY (IDRelatorio, idtecnologia), 

CONSTRAINT fk_IDRelatorio FOREIGN KEY (IDRelatorio) REFERENCES RELATORIO(IDRelatorio), 

CONSTRAINT fk_IDtecnologia FOREIGN KEY (idtecnologia) REFERENCES TECNOLOGIA(idtecnologia) 

); 

CREATE TABLE CursoEmpresa( 

CNPJ INTEGER, 

ID_Curso INTEGER, 

CONSTRAINT pk_CursoEmpresa PRIMARY KEY (CNPJ, ID_Curso), 

CONSTRAINT fk_CNPJ FOREIGN KEY (CNPJ) REFERENCES Empresa_parceira(CNPJ), 

CONSTRAINT fk_ID_Curso FOREIGN KEY (ID_Curso) REFERENCES nome_curso(ID_Curso) 

); 

INSERT INTO empresa_parceira VALUES 

(26986452,'tech inside','Rua Maria Augusta, São João de Meriti, RJ'), 

(10254897,'genio digital','Av. Cardoso Fonte, Centro, RJ'), 

(52123695,'planeta tech','Rua 7 de setembro,Centro, RJ'), 

(62547890,'sos tec','Rua da Alfanega, Centro ,RJ'); 


INSERT INTO TECNOLOGIA VALUES 

(100,'Execel','4tec'), 

(200,'seguranca da informcao','Tech World'), 

(300,'Suporte tecnico','Alta Tech'), 

(400,'programacao','TecTop'), 

(500,'programador mobile','TecnoMax');


INSERT INTO relatorio VALUES 

(58840,1247894,'2021-04-10'),

(64785,7895548,'2010-05-20'),

(89654,8796541,'2023-01-23'), 

(32154,1235478,'2022-07-30'), 

(78447,1247856,'2011-09-23');

INSERT nome_curso VALUES

(154788,'Sistemas para internet','TecMundo'),

(125478,'Sistema de informacao','TecWorld'),

(123654,'Jogos Digitais','MundoTec'),

(145879,'Engenharia de Software','Info'),

(124578,'Computacao','TecJobb');

INSERT INTO relatorio VALUES 

(45688,100), 

(45877,200), 

(20147,300), 

(35874,400), 

(77894,500);
 
INSERT INTO cursoempresa VALUES 

(12457896,120305), 

(25478963,154205), 

(22035478,032147), 

(30214578,120448), 

(55448899,145897);

1.Qual empresa utiliza o maior número de tecnologias na última pesquisa (2/2022)? 

SELECT TOP 1 empresa_parceira.cnpj, empresa_parceiranNome, COUNT(*) AS NUM_TEC 
FROM empresa_parceira 
LEFT JOIN relatorio ON empresa_parceira.cnpj = relatorio.cnpj 
LEFT JOIN Relatorio_tec ON relatorio.idrelatorio = relatorio.idrelatorio 
WHERE relatorio.data_compilacao >= '2022-07-01' AND relatorio.data_compilacao <= '2022-02-02' 
GROUP BY empresa_parceira.cnpj, empresa_parceira.nome 
ORDER BY NUM_TEC DESC; 

2. Qual empresa utilizava o menor número de tecnologias na pesquisa anterior (1/2022)? 

SELECT Empresa_parceira.cnpj, empresa_parceira.nome, COUNT(*) 
LEFT 
LEFT AS NUM_TEC 
FROM empresa_parceira
LEFT 
LEFT LEFT JOIN relatorio 
ON empresa_parceira.cnpj = relatorio.cnpj 
LEFT JOIN relatorio_tec 
ON relatorio.idrelatorio = relatorio_tec.idrelatorio 
WHERE relatorio.data_compilacao >= '2022-02-02' AND relatorio.data_compilacao <= '2022-02-02' 
GROUP BY empresa_parceira.cnpj, empresa_parceira.nome 
ORDER BY NUM_TEC ASC 
OFFSET 0 ROWS
FETCH FIRST 1 ROWS ONLY;

3. Quantas empresas utilizam tecnologias da área de “Dados” atualmente? 

SELECT COUNT (empresa_parceira.cnpj 

FROM empresa_parceira 

LEFT JOIN relatorio 

ON empresa_parceira.cnpj = relatorio.cnpj 

LEFT JOIN Relatorio_tec 

ON relatorio.idrelatorio = Relatorio_tec.idrelatorio 

LEFT JOIN empresa_parceira 

ON relatorio_tec.idtecnologia= empresa_parceira.idtecnologia 

WHERE empresa_parceira.area = 'Dados' AND relatorio.data_compilacao > '2022-02-02'; 

4. Quantas empresas utilizam tecnologias que não são da área de “Dados” atualmente? 

SELECT COUNT (DISTINCT empresa_parceira.cnpj) 

FROM empresa_parceira 

LEFT JOIN relatorio 

ON empresa_parceira.cnpj = relatorio.cnpj 

LEFT JOIN Relatorio_tec  

ON relatorio.idrelatorio = Relatorio_tec.idrelatorio 

LEFT JOIN Empresa_parceira 

ON Relatorio_tec.idtecnologia = empresa_parceira.idtecnologia 

WHERE empresa_parceira.area != 'Dados' AND relatorio.data_compilacao > '2022-02-02'; 



