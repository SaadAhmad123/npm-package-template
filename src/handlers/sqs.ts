import { SQSEvent, Context } from 'aws-lambda';

export default async function sqsHandler(
  event: SQSEvent,
  context: Context,
): Promise<void> {}
