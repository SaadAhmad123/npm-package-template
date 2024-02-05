import { EventBridgeEvent, Context } from 'aws-lambda';

export default async function eventBridgeHandler(
  event: EventBridgeEvent<any, any>,
  context: Context,
): Promise<void> {}
