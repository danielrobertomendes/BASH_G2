#!/bin/bash
#
# Script criado em 30/11/2016
# Escrito por Daniel Roberto Mendes para a disciplina de Shell Script
# Este script tem com funcionamento disponibilizar formas de efetuar um backup de arquivos em computadores distintos.
# 



principal() {           		  # Função principal do programa
    clear                         # limpa a tela

    echo "[1] Definir arquivo"    # imprime na tela as opções que serão
    echo "[2] Definir diretório"  # abordadas no comando case
    echo "[3] Definir caminho"
    echo "[4] Definir socket"
    echo "[5] Definir software de backup"
    echo "[6] Efetuar backup"
    echo "[7] Sair"
    echo ""
    echo -n "Qual a opcao desejada ? "
    read opcao          		  # faz a leitura da variável "opcao", 
                                  # que será utilizada no comando case
                                  # para indicar qual a opção a ser utilizada

                                  # caso o valor da variável "opcao"...
    case $opcao in
        1)                        # seja igual a "1", então faça as instruções abaixo
            clear
            define_arquivo        # executa os comandos da função "define_arquivo"
            ;;          	      # os 2 ";;" (ponto e virgula)
								  # significam que chegou ao final
								  # esta opção do comando case
        2)              		  # seja igual a "2", então faça as instruções abaixo
            clear
            define_diretorio      # executa os comandos da função "define_diretorio"
            ;;          		  # os 2 ";;" (ponto e virgula)
								  # significam que chegou ao final
								  # esta opção do comando case
        3)              		  # seja igual a "3", então faça as instruções abaixo
            clear
            define_caminho        # executa os comandos da função "define_caminho"
            ;;          		  # os 2 ";;" (ponto e virgula)
								  # significam que chegou ao final
								  # esta opção do comando case
        4)              		  # seja igual a "4", então faça as instruções abaixo
            clear
            define_socket     	  # executa os comandos da função "define_socket"
            ;;          		  # os 2 ";;" (ponto e virgula)
								  # significam que chegou ao final
								  # esta opção do comando case
        5)              		  # seja igual a "5", então faça as instruções abaixo
            clear
            define_software       # executa os comandos da função "define_software"
            ;;             		  # os 2 ";;" (ponto e virgula)
								  # significam que chegou ao final
								  # esta opção do comando case
        6)              		  # seja igual a "6", então faça as instruções abaixo
            clear
            efetua_backup     	  # executa os comandos da função "efetua_backup"
            ;;          		  # os 2 ";;" (ponto e virgula)
								  # significam que chegou ao final
								  # esta opção do comando case
        7)
            clear
            exit ;;
        *)              		  # esta opçao existe para caso o usuário digite um 
								  # valor diferente de 1, 2 ou 3
            opcao_invalida ;;
    esac
}

define_arquivo() {             	  # função da opção define_arquivo
    clear
    echo "Qual o nome completo e extensão do arquivo que deseja copiar? [Use *,para todos os arquivos de um diretório]"
    read nomeArquivo
    read pause          		  # usado para pausar a execução do script
    principal           		  # volta para a função principal
}

define_diretorio() {              # função da opção define_diretorio
    clear
    echo "Qual o nome do diretório que deseja copiar? [Especifique corretamente letras mauísculas e minusculas Exemplo: Documents]"
    echo "Você tambem pode colocar a referência absoluta: [Exemplo: /home/user/Downloads/]"
    read nomeDiretorio
    read pause
    principal
}

define_caminho() {                # função da opção caminho
    clear
    echo "Qual a referência completa do caminho de destino para onde deseja copiar [Exemplo: ~/Documents]"
    read nomeCaminho
    read pause          		  # usado para pausar a execução do script
    principal           		  # volta para a função principal
}

define_socket() {                 # função da opção define_socket
    clear
    echo "Qual o IP de conexão remota para backup?"
    read enderecoIp
    echo "Qual a porta SSH padrão do host remoto?"
    read portaSsh
    echo "Qual o usuário remoto para efetuar o backup?"
    read usuarioBackup
    read pause					  # usado para pausar a execução do script
    principal	     			  # volta para a função principal
}

define_software() {               # função da opção define_software
    clear
    echo "Qual o software que deseja usar para o backup? - [1] RSYNC | [2] SCP]"
    read sBack
echo "teste"
    clear
    if test $sBack -eq 1
	then
	clear
	echo "Função RSYNC escolhida."	
	principal

    elif test $sBack -eq 2
	then
	clear
	echo "Função SCP escolhida."
	principal

    else
	clear
	echo "Opção inválida."
	define_software
    fi
    read pause          		  # usado para pausar a execução do script
    principal           		  # volta para a função principal
}
efetua_backup(){				  # função da opção efetua_backup
    clear
    echo "EFETUADO BACKUP CONFORME DADOS PASSADOS...]"
    if [ $sBack -eq 1]
	then
	clear
	echo "Utilizando RSYNC..."
	rsync -vzha -e 'ssh -p $portaSsh' --progress $nomeDiretorio/$nomeArquivo $usuarioBackup@$enderecoIp:$nomeCaminho
    elif [ $sBack -eq 2]
	then
	clear
	echo "Utilizando SCP..."
	scp -vP $portaSsh $nomeDiretorio/$nomeArquivo $usuarioBackup@enderecoIp:$nomeCaminho
    else
	clear
	echo "Opção inválida."
	echo "Não foi possivel fazer o backup, cancele a execução do script e repita o processo."
    fi
    echo "Script finalizado, verifique o backup!"
    read pause          		 # usado para pausar a execução do script
    clear
    exit 0
}


opcao_invalida() {      	  	 # função da opção inválida
    clear
    echo "Opcao desconhecida."
    read pause
    principal
}

principal               		 # o script começa aqui, as funções das linhas anteriores
								 # são lidas pelo interpretador bash e armazenadas em memória.

								 # o bash não tem como adivinhar qual das funções ele deve 
								 # executar, por isto o a execução do script realmente começa
								 # quando aparece uma instrução fora de uma função, neste caso,
								 # chamando a função principal
