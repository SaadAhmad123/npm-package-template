import {
    APIGatewayProxyResultV2,
} from 'aws-lambda';

export function createResponse(
    data: Record<string, any>,
    statusCode: number,
): APIGatewayProxyResultV2 {
    return {
        statusCode,
        headers: {
            'content-type': 'application/json'
        },
        body: JSON.stringify(data||{}),
    }
}

export function successResponse(data: Record<string, any>) {
    return createResponse(data, 200)
}

export function errorResponse(error: Error, data: Record<string, any> = {}, statusCode: number = 500) {
    return createResponse({
        error: {
            name: error.name,
            message: error.message,
            stack: error.stack,
        },
        ...data
    }, statusCode)
}