#!bin/bash

if [ ! -d log ]
then 
	mkdir log
fi

#lista processos mostrando apenas o pid, depois ordenando pelo tamanho. O resultado
#é direcionado para o comando head que imprime os 10 primeiros. esse resultado por
#sua vez é novamente direcionado para o grep excluir a primeira linha que contem a escrita PID
processo_memoria(){
processos=$(ps -e -o pid --sort -size | head -n 11 | grep [0-9])
for pid in $processos
do
	#lista apenas o processo selecionado mostrando apenas o nome
	nome_processo=$(ps -p $pid -o comm=)
	echo -n $(date +%F,%H:%M:%S,) >> log/$nome_processo.log
	tamanho_processo=$(ps -p $pid -o size | grep [0-9])
	echo "$(bc <<< "scale=2;$tamanho_processo/1024") MB" >> log/$nome_processo.log 
done
}
processo_memoria
if [ $? -eq 0 ]
then
	echo "Log salvo com sucesso"
else
	echo "Houve algum erro no processo"
fi
