import { HttpRequest, InvocationContext } from "@azure/functions";
import {errorResponse, successResponse} from '../utils/index'


async function handler(context: InvocationContext, request: HttpRequest) {
  const response = successResponse({
    name: "Saad Ahmad",
    method: request.method
  })
  return response
}

module.exports = handler