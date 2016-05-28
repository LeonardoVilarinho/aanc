<?php
/**
 * Created by PhpStorm.
 * User: Leonardo Vilarinho
 * Date: 27/05/2016
 * Time: 11:37
 */

require_once 'ModelCurso.aanc';

class ModelCursoTest extends PHPUnit_Framework_TestCase
{

 /**
  * Verifica se houve retorno na listagem dos cursos
  * @test esperado OK 
  */
 public function testListagemCursos()
 {
  $model = new ModelCurso();
  $resultado = $model->preparaListagem("curso");
  $this->assertTrue(count($resultado) > 0 and !empty($resultado));
 }
}

