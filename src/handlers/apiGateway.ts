import {
  APIGatewayProxyEventV2,
  APIGatewayProxyStructuredResultV2,
  Context,
} from 'aws-lambda';

export default async function apiGatewayHandler(
  event: APIGatewayProxyEventV2,
  context: Context,
): Promise<APIGatewayProxyStructuredResultV2 | undefined> {
  // TODO: Define API Gateway Handler 
  return undefined
}
