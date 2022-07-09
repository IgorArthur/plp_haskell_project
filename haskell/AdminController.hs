module AdminController where

import Client
import Admin
import Mechan
import Service
import Control.Concurrent

import Utils

type Interaction = (Int -> IO())

registerMechanic :: Int -> (Int -> IO()) -> IO()
registerMechanic id  adminInteraction = do
    idMecanico <- getString "Digite o Id do mecânico: "
    nomeMecanico <- getString "Digite o nome do mecânico: " 
    contatoMecanico <- getString "Digite o contato do mecânico: "

    criarMecanico (read idMecanico) nomeMecanico contatoMecanico
    threadDelay 1000000

    clearScreen
    adminInteraction id
    
    
registerService :: Int -> (Int -> IO()) -> IO()
registerService id  adminInteraction = do
    idServico <- getString "Digite o código do serviço: "
    nomeCliente <- getString "Digite o nome do cliente: " 
    contatoCliente <- getString "Digite o contato do cliente: "
    modeloAutomovel <- getString "Digite o modelo do automóvel: "
    placaAutomovel <- getString "Digite a placa do automóvel: "
    idMecanico <- getString "Digite o Id do mecânico responsável: "

    criarServiço (read idServico) nomeCliente contatoCliente modeloAutomovel placaAutomovel (read idMecanico)
    threadDelay 1000000

    clearScreen
    adminInteraction id

registerClient ::  Int -> (Int -> IO()) -> IO()
registerClient id adminInteraction = do
    idCliente <- getString "Digite o Id do cliente: "
    nomeCliente <- getString "Digite o nome do cliente: "
    contatoCliente <- getString "Digite o contato do cliente: "
    
    criarCliente (read idCliente) nomeCliente contatoCliente
    threadDelay 1000000

    clearScreen
    adminInteraction id