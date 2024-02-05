import { SNSEvent, Context } from 'aws-lambda';

export default async function snsHandler(
  event: SNSEvent,
  context: Context,
): Promise<void> {}
