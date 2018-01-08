defmodule BshipWeb.PageController do
  use BshipWeb, :controller
  alias Bship.App
  def index(conn, _params) do
    apps = App.list_apps()
    render conn, "index.html", apps: apps
  end

  @apidoc """
  @apiDefine s_app_info
  @apiSuccess {integer} data.eq 平-获取的积分
  @apiSuccess {integer} data.gt 赢-获取的积分
  @apiSuccess {integer} data.lt 输-获取的积分
  @apiSuccess {integer} data.name 游戏名称
  @apiSuccess {integer} data.id 游戏id
  """

  @apidoc """
  @apiDescription 获取应用列表
  @api {get} /api/apps 获取应用列表
  @apiVersion 0.0.1
  @apiGroup App
  @apiName apps
  @apiPermission none
  @apiSuccess {object[]} data
  @apiUse s_app_info
  @apiSuccessExample {json} Success-Example:
  {"data":[{"updated_at":"2017-12-25T07:09:11.007311","name":"BattleShip","lt":0,"inserted_at":"2017-12-11T08:15:22.053108","id":1,"gt":10,"eq":5},{"updated_at":"2017-12-25T09:34:00.414595","name":"Mines","lt":1,"inserted_at":"2017-12-24T07:51:50.774782","id":4,"gt":4,"eq":2}]}
  """
  def apps(conn, _params) do
    apps = App.list_apps()
    json(conn,%{data: apps})
  end

  @apidoc """
  @apiDescription 获取应用
  @api {get} /api/app/:type 获取应用
  @apiVersion 0.0.1
  @apiGroup App
  @apiName app
  @apiPermission none
  @apiSuccess {object} data
  @apiUse s_app_info
  @apiSuccessExample {json} Success-Example:
  {"data":{"updated_at":"2017-12-25T07:09:11.007311","name":"BattleShip","lt":0,"inserted_at":"2017-12-11T08:15:22.053108","id":1,"gt":10,"eq":5}}
  """
  def app(conn, %{"id"=>id}) do
    app_info = App.get_app_info!(id)
    json(conn,%{data: app_info})
  end

  @apidoc """
  @apiDescription 获取应用2
  @api {get} /api/app2/ 获取应用2
  @apiVersion 0.0.1
  @apiGroup App2
  @apiName app2
  @apiPermission none
  @apiParam {integer} id 应用id
  @apiParamExample {json} Request-Example:
  {"id": 1}
  @apiSuccess {object} data
  @apiUse s_app_info
  @apiSuccessExample {json} Success-Example:
  {"data":{"updated_at":"2017-12-25T07:09:11.007311","name":"BattleShip","lt":0,"inserted_at":"2017-12-11T08:15:22.053108","id":1,"gt":10,"eq":5}}
  """
  def app2(conn, %{"id"=>id}) do
    app_info = App.get_app_info(id)
    json(conn,%{data: app_info})
  end
end
