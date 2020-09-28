<?php 
    class Dashboard {
        private $data_inicio;
        private $data_fim;
        private $vendas;
        private $despesas;
        private $clientes;
        private $feedbacks;

        public function __get($atributo) {
            return $this->$atributo;
        }

        public function __set($atributo, $valor) {
            $this->$atributo = $valor;

            return $this;
        }

        public function toJson() {
            $json = ['vendas' => $this->vendas,
                    'despesas' => $this->despesas,
                    'clientes' => $this->clientes,
                    'feedbacks' => $this->feedbacks];

            return  json_encode($json);
        }
    }

    class Conexao {
        private $host = 'localhost';
        private $dbname = 'db_dashboard';
        private $user = 'usr_dashboard';
        private $pass = 'zAk0@.;99lQ';

        public function conectar() {

            try {
                $conexao = new PDO("mysql:host=$this->host; dbname=$this->dbname","$this->user", "$this->pass");
                $conexao->exec('set charset set utf8');
                
                return $conexao;

            } catch (PDOException $e) {
                echo '<p> '.$e->getMensage().'</p>';
            } 
        }
    }

    class Indicador {
        private $conexao;
        private $dashboard;

        public function __construct(Conexao $conexao, Dashboard $dashboard) {
            $this->conexao = $conexao->conectar();
            $this->dashboard = $dashboard; 
        }

        private function execVendas() {
            $query = '
                        SELECT 
                            COUNT(id) AS num, SUM(total) AS total
                        FROM
                            tb_vendas
                        WHERE
                            data_venda BETWEEN :data_inicio AND :data_fim
            ';

            $stmt = $this->conexao->prepare($query);

            $stmt->bindValue(':data_inicio', $this->dashboard->__get('data_inicio'));
            $stmt->bindValue(':data_fim', $this->dashboard->__get('data_fim'));
            $stmt->execute();

            $this->dashboard->__set('vendas', $stmt->fetch(PDO::FETCH_OBJ));
        }

        private  function execDespesas() {
            $query = '
                        SELECT 
                            SUM(total) AS total
                        FROM
                            tb_despesas
                        WHERE
                            data_despesa BETWEEN :data_inicio AND :data_fim
            ';

            $stmt = $this->conexao->prepare($query);

            $stmt->bindValue(':data_inicio', $this->dashboard->__get('data_inicio'));
            $stmt->bindValue(':data_fim', $this->dashboard->__get('data_fim'));
            $stmt->execute();

            $this->dashboard->__set('despesas', $stmt->fetch(PDO::FETCH_OBJ));
        }

        private function execClientes() {
            $query = '
                        SELECT 
                            SUM(IF(cliente_ativo = 1, 1, 0)) AS ativo,
                            SUM(IF(cliente_ativo = 0, 1, 0)) AS inativo
                        FROM
                            tb_clientes
            ';

            $stmt = $this->conexao->prepare($query);
            $stmt->execute();

            $this->dashboard->__set('clientes', $stmt->fetch(PDO::FETCH_OBJ));
        }

        private function execFeedbacks() {
            $query = '
                        SELECT 
                            SUM(IF(tipo_contato = 1, 1, 0)) AS criticas,
                            SUM(IF(tipo_contato = 2, 1, 0)) AS sugestoes,
                            SUM(IF(tipo_contato = 3, 1, 0)) AS elogios
                        FROM
                            tb_contatos
            ';

            $stmt = $this->conexao->prepare($query);
            $stmt->execute();

            $this->dashboard->__set('feedbacks', $stmt->fetch(PDO::FETCH_OBJ));
        }

        public function run() {
            $this->execVendas(); 
            $this->execDespesas(); 
            $this->execClientes(); 
            $this->execFeedbacks();

            return $this->dashboard;
        } 
    }

    $dashboard = new Dashboard();
    $conexao = new Conexao();


    $data = explode('-', $_POST['competencia']);
    $data[] = cal_days_in_month(CAL_GREGORIAN, $data[1], $data[0]);

    $dashboard->__set('data_inicio', "$data[0]-$data[1]-01")->
                __set('data_fim', "$data[0]-$data[1]-$data[2]");

    $indicadores = new Indicador($conexao, $dashboard);
    $indicadores->run();

    //echo '<pre>';
        echo $dashboard->toJson();
    //echo '</pre>';

?>