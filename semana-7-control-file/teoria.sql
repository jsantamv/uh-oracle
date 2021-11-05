/*----------------< CONTROL FILE > ---------------------
 * - Nombre de la base de datos asociada
 * - Ubicacion fisica dentro del sistema operativo
 * - Tiempo de creacion
 * - Lleva la secuencia de los log (numero de log)
 * - Checkpoint Information
 * - Es binario
 * ----------------------------------------------------*/

-- Etapas MOUNT para Montar la base de datos ==> starup
-- 1. Shutdown
-- 2. Nomount 	--Instace Started
-- 3. Mount   	--Control file opened for this instance
-- 4. Open		--allfiles opened as describied by the control files for this instace

-- Etapas NOMOUNT para des Montar la base de datos ==> shutdown
-- 1. Open		--allfiles opened as describied by the control files for this instace
-- 2. Mount   	--Control file opened for this instance
-- 3. Nomount 	--Instace Started
-- 4. Shutdown

-- Multiplexado: Genere o tener copias del archivo en varios lados. Copia fidedigna. 

--Cuando se crea un control File? 
    -- 1. Cuando se daña, es poco probable pero es bueno tener copias del control file. 
    -- 2. 