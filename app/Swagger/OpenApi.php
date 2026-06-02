<?php

namespace App\Swagger;

/**
 * @OA\Info(
 *     title="Kanisoft Backend API",
 *     version="1.0.0",
 *     description="Browser-testable API documentation for the Kanisoft Laravel backend."
 * )
 * @OA\Server(
 *     url=L5_SWAGGER_CONST_HOST,
 *     description="Application server"
 * )
 * @OA\SecurityScheme(
 *     securityScheme="bearerAuth",
 *     type="http",
 *     scheme="bearer",
 *     bearerFormat="Sanctum token"
 * )
 * @OA\Tag(name="Authentication", description="Registration, login, profile, password, and user session endpoints")
 * @OA\Tag(name="Members", description="Member management endpoints")
 * @OA\Tag(name="Groups", description="Group management endpoints")
 * @OA\Tag(name="Events", description="Event management endpoints")
 * @OA\Tag(name="Services", description="Service and service event endpoints")
 * @OA\Tag(name="Attendance", description="Service attendance endpoints")
 * @OA\Tag(name="People", description="Guests, children, leaders, and leadership role endpoints")
 * @OA\Tag(name="Finance", description="Contribution and asset endpoints")
 * @OA\Tag(name="Gallery", description="Public gallery and protected gallery upload endpoints")
 * @OA\Tag(name="SMS", description="SMS send and log endpoints")
 * @OA\Schema(
 *     schema="ApiError",
 *     type="object",
 *     @OA\Property(property="status", type="string", example="error"),
 *     @OA\Property(property="message", type="string", example="Validation failed")
 * )
 * @OA\Schema(
 *     schema="ApiSuccess",
 *     type="object",
 *     @OA\Property(property="status", type="string", example="success"),
 *     @OA\Property(property="message", type="string", example="Operation completed successfully")
 * )
 * @OA\Schema(
 *     schema="LoginRequest",
 *     type="object",
 *     required={"login", "password"},
 *     @OA\Property(property="login", type="string", example="member@example.com", description="Email address or phone number"),
 *     @OA\Property(property="password", type="string", format="password", example="secret123")
 * )
 * @OA\Schema(
 *     schema="LoginResponse",
 *     type="object",
 *     @OA\Property(property="status", type="string", example="success"),
 *     @OA\Property(property="message", type="string", example="Login successful"),
 *     @OA\Property(property="token", type="string", example="1|plain-text-sanctum-token"),
 *     @OA\Property(property="user", type="object"),
 *     @OA\Property(property="leadership_roles", type="array", @OA\Items(type="string"))
 * )
 * @OA\Schema(
 *     schema="RegisterRequest",
 *     type="object",
 *     required={"full_name", "gender", "phone", "email", "password", "password_confirmation", "occupation"},
 *     @OA\Property(property="full_name", type="string", example="John Doe"),
 *     @OA\Property(property="gender", type="string", enum={"M", "F", "Mwanaume", "Mwanamke"}, example="M"),
 *     @OA\Property(property="phone", type="string", example="255767983236"),
 *     @OA\Property(property="email", type="string", format="email", example="john@example.com"),
 *     @OA\Property(property="password", type="string", format="password", example="secret123"),
 *     @OA\Property(property="password_confirmation", type="string", format="password", example="secret123"),
 *     @OA\Property(property="occupation", type="string", example="Teacher"),
 *     @OA\Property(property="birth_date", type="string", format="date", nullable=true),
 *     @OA\Property(property="birth_place", type="string", nullable=true),
 *     @OA\Property(property="marital_status", type="string", nullable=true),
 *     @OA\Property(property="zone", type="string", nullable=true),
 *     @OA\Property(property="residential_ward", type="string", nullable=true),
 *     @OA\Property(property="residential_street", type="string", nullable=true)
 * )
 * @OA\Schema(
 *     schema="GenericJsonRequest",
 *     type="object",
 *     additionalProperties=true,
 *     example={"name": "Example value"}
 * )
 */
class OpenApi
{
}
