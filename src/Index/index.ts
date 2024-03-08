import { HttpRequest, InvocationContext, HttpResponse } from "@azure/functions";

async function handler(context: InvocationContext, request: HttpRequest): Promise<HttpResponse> {
  return new HttpResponse({
    body: "Hello, world!",
    status: 200,
  })
}

module.exports = handler