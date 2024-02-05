import {
  APIGatewayProxyEventV2,
  APIGatewayProxyStructuredResultV2,
  SNSEvent,
  EventBridgeEvent,
  SQSEvent,
  Context,
} from 'aws-lambda';
import apiGatewayHandler from './handlers/apiGateway';
import snsHandler from './handlers/sns';
import sqsHandler from './handlers/sqs';
import eventBridgeHandler from './handlers/eventBridge';

type HandlerEvent =
  | APIGatewayProxyEventV2
  | SNSEvent
  | EventBridgeEvent<any, any>
  | SQSEvent;

export default async function handler(
  event: HandlerEvent,
  context: Context,
): Promise<APIGatewayProxyStructuredResultV2 | undefined> {
  if ((event as APIGatewayProxyEventV2)?.requestContext?.http?.method) {
    return await apiGatewayHandler(event as APIGatewayProxyEventV2, context);
  }
  if ((event as SNSEvent)?.Records?.[0]?.EventSource === 'aws:sns') {
    return await snsHandler(event as SNSEvent, context);
  }
  if ((event as SQSEvent)?.Records?.[0]?.eventSource === 'aws:sqs') {
    return await sqsHandler(event as SQSEvent, context);
  }
  if ((event as EventBridgeEvent<any, any>)?.['detail-type']) {
    return await eventBridgeHandler(
      event as EventBridgeEvent<any, any>,
      context,
    );
  }
  return undefined
}
