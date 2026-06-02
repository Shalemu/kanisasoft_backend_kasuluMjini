<?php

namespace App\Swagger;

class ResourcePaths
{
    /**
     * @OA\Get(path="/api/gallery", tags={"Gallery"}, summary="List public gallery items", @OA\Response(response=200, description="Gallery items", @OA\JsonContent(type="object")))
     * @OA\Post(path="/api/gallery", tags={"Gallery"}, summary="Upload a gallery item", security={{"bearerAuth": {}}}, @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=200, description="Gallery item created", @OA\JsonContent(type="object")), @OA\Response(response=401, description="Unauthenticated", @OA\JsonContent(ref="#/components/schemas/ApiError")))
     * @OA\Delete(path="/api/gallery/{id}", tags={"Gallery"}, summary="Delete a gallery item", security={{"bearerAuth": {}}}, @OA\Parameter(name="id", in="path", required=true, @OA\Schema(type="integer")), @OA\Response(response=200, description="Gallery item deleted", @OA\JsonContent(type="object")), @OA\Response(response=401, description="Unauthenticated", @OA\JsonContent(ref="#/components/schemas/ApiError")))
     */
    public function gallery(): void
    {
    }

    /**
     * @OA\Get(path="/api/members", tags={"Members"}, summary="List members", security={{"bearerAuth": {}}}, @OA\Response(response=200, description="Members list", @OA\JsonContent(type="object")))
     * @OA\Post(path="/api/members", tags={"Members"}, summary="Create a member", security={{"bearerAuth": {}}}, @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=201, description="Member created", @OA\JsonContent(type="object")))
     * @OA\Get(path="/api/members/{member}", tags={"Members"}, summary="Show a member", security={{"bearerAuth": {}}}, @OA\Parameter(name="member", in="path", required=true, @OA\Schema(type="integer")), @OA\Response(response=200, description="Member", @OA\JsonContent(type="object")))
     * @OA\Put(path="/api/members/{member}", tags={"Members"}, summary="Update a member", security={{"bearerAuth": {}}}, @OA\Parameter(name="member", in="path", required=true, @OA\Schema(type="integer")), @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=200, description="Member updated", @OA\JsonContent(type="object")))
     * @OA\Delete(path="/api/members/{member}", tags={"Members"}, summary="Delete a member", security={{"bearerAuth": {}}}, @OA\Parameter(name="member", in="path", required=true, @OA\Schema(type="integer")), @OA\Response(response=200, description="Member deleted", @OA\JsonContent(type="object")))
     * @OA\Get(path="/api/members/stats", tags={"Members"}, summary="Get member statistics", security={{"bearerAuth": {}}}, @OA\Response(response=200, description="Member statistics", @OA\JsonContent(type="object")))
     * @OA\Get(path="/api/members/by-user/{user}", tags={"Members"}, summary="Get member by user id", security={{"bearerAuth": {}}}, @OA\Parameter(name="user", in="path", required=true, @OA\Schema(type="integer")), @OA\Response(response=200, description="Member", @OA\JsonContent(type="object")))
     * @OA\Post(path="/api/members/{member}/activate", tags={"Members"}, summary="Activate a member", security={{"bearerAuth": {}}}, @OA\Parameter(name="member", in="path", required=true, @OA\Schema(type="integer")), @OA\Response(response=200, description="Member activated", @OA\JsonContent(type="object")))
     * @OA\Post(path="/api/members/{member}/deactivate", tags={"Members"}, summary="Deactivate a member", security={{"bearerAuth": {}}}, @OA\Parameter(name="member", in="path", required=true, @OA\Schema(type="integer")), @OA\RequestBody(required=false, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=200, description="Member deactivated", @OA\JsonContent(type="object")))
     * @OA\Post(path="/api/authorize-user", tags={"Members"}, summary="Authorize a user/member", security={{"bearerAuth": {}}}, @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=200, description="User authorized", @OA\JsonContent(type="object")))
     */
    public function members(): void
    {
    }

    /**
     * @OA\Get(path="/api/groups", tags={"Groups"}, summary="List groups", security={{"bearerAuth": {}}}, @OA\Response(response=200, description="Groups list", @OA\JsonContent(type="object")))
     * @OA\Post(path="/api/groups", tags={"Groups"}, summary="Create a group", security={{"bearerAuth": {}}}, @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=201, description="Group created", @OA\JsonContent(type="object")))
     * @OA\Get(path="/api/groups/{group}", tags={"Groups"}, summary="Show a group", security={{"bearerAuth": {}}}, @OA\Parameter(name="group", in="path", required=true, @OA\Schema(type="integer")), @OA\Response(response=200, description="Group", @OA\JsonContent(type="object")))
     * @OA\Put(path="/api/groups/{group}", tags={"Groups"}, summary="Update a group", security={{"bearerAuth": {}}}, @OA\Parameter(name="group", in="path", required=true, @OA\Schema(type="integer")), @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=200, description="Group updated", @OA\JsonContent(type="object")))
     * @OA\Delete(path="/api/groups/{group}", tags={"Groups"}, summary="Delete a group", security={{"bearerAuth": {}}}, @OA\Parameter(name="group", in="path", required=true, @OA\Schema(type="integer")), @OA\Response(response=200, description="Group deleted", @OA\JsonContent(type="object")))
     * @OA\Get(path="/api/groups/{id}/members", tags={"Groups"}, summary="List group members", security={{"bearerAuth": {}}}, @OA\Parameter(name="id", in="path", required=true, @OA\Schema(type="integer")), @OA\Response(response=200, description="Group members", @OA\JsonContent(type="object")))
     * @OA\Post(path="/api/groups/{group}/add-member", tags={"Groups"}, summary="Add a member to a group", security={{"bearerAuth": {}}}, @OA\Parameter(name="group", in="path", required=true, @OA\Schema(type="integer")), @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=200, description="Member added", @OA\JsonContent(type="object")))
     * @OA\Post(path="/api/groups/{group}/remove-member", tags={"Groups"}, summary="Remove a member from a group", security={{"bearerAuth": {}}}, @OA\Parameter(name="group", in="path", required=true, @OA\Schema(type="integer")), @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=200, description="Member removed", @OA\JsonContent(type="object")))
     * @OA\Post(path="/api/groups/{group}/assign-leader", tags={"Groups"}, summary="Assign a leader to a group", security={{"bearerAuth": {}}}, @OA\Parameter(name="group", in="path", required=true, @OA\Schema(type="integer")), @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=200, description="Leader assigned", @OA\JsonContent(type="object")))
     */
    public function groups(): void
    {
    }

    /**
     * @OA\Get(path="/api/events", tags={"Events"}, summary="List events", security={{"bearerAuth": {}}}, @OA\Response(response=200, description="Events list", @OA\JsonContent(type="object")))
     * @OA\Post(path="/api/events", tags={"Events"}, summary="Create an event", security={{"bearerAuth": {}}}, @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=201, description="Event created", @OA\JsonContent(type="object")))
     * @OA\Get(path="/api/events/past", tags={"Events"}, summary="List past events", security={{"bearerAuth": {}}}, @OA\Response(response=200, description="Past events", @OA\JsonContent(type="object")))
     * @OA\Get(path="/api/events/{event}", tags={"Events"}, summary="Show an event", security={{"bearerAuth": {}}}, @OA\Parameter(name="event", in="path", required=true, @OA\Schema(type="integer")), @OA\Response(response=200, description="Event", @OA\JsonContent(type="object")))
     * @OA\Put(path="/api/events/{event}", tags={"Events"}, summary="Update an event", security={{"bearerAuth": {}}}, @OA\Parameter(name="event", in="path", required=true, @OA\Schema(type="integer")), @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=200, description="Event updated", @OA\JsonContent(type="object")))
     * @OA\Delete(path="/api/events/{event}", tags={"Events"}, summary="Delete an event", security={{"bearerAuth": {}}}, @OA\Parameter(name="event", in="path", required=true, @OA\Schema(type="integer")), @OA\Response(response=200, description="Event deleted", @OA\JsonContent(type="object")))
     */
    public function events(): void
    {
    }

    /**
     * @OA\Get(path="/api/attendance", tags={"Attendance"}, summary="List attendance records", security={{"bearerAuth": {}}}, @OA\Response(response=200, description="Attendance records", @OA\JsonContent(type="object")))
     * @OA\Post(path="/api/attendance", tags={"Attendance"}, summary="Store attendance", security={{"bearerAuth": {}}}, @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=201, description="Attendance stored", @OA\JsonContent(type="object")))
     * @OA\Get(path="/api/attendance/{serviceId}", tags={"Attendance"}, summary="Show attendance for a service", security={{"bearerAuth": {}}}, @OA\Parameter(name="serviceId", in="path", required=true, @OA\Schema(type="integer")), @OA\Response(response=200, description="Service attendance", @OA\JsonContent(type="object")))
     * @OA\Post(path="/api/services", tags={"Services"}, summary="Create a service", security={{"bearerAuth": {}}}, @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=201, description="Service created", @OA\JsonContent(type="object")))
     * @OA\Get(path="/api/service-events", tags={"Services"}, summary="List service events", security={{"bearerAuth": {}}}, @OA\Response(response=200, description="Service events", @OA\JsonContent(type="object")))
     * @OA\Post(path="/api/service-events", tags={"Services"}, summary="Create a service event", security={{"bearerAuth": {}}}, @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=201, description="Service event created", @OA\JsonContent(type="object")))
     * @OA\Get(path="/api/service-events/{id}", tags={"Services"}, summary="Show a service event", security={{"bearerAuth": {}}}, @OA\Parameter(name="id", in="path", required=true, @OA\Schema(type="integer")), @OA\Response(response=200, description="Service event", @OA\JsonContent(type="object")))
     * @OA\Put(path="/api/service-events/{id}", tags={"Services"}, summary="Update a service event", security={{"bearerAuth": {}}}, @OA\Parameter(name="id", in="path", required=true, @OA\Schema(type="integer")), @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=200, description="Service event updated", @OA\JsonContent(type="object")))
     * @OA\Delete(path="/api/service-events/{id}", tags={"Services"}, summary="Delete a service event", security={{"bearerAuth": {}}}, @OA\Parameter(name="id", in="path", required=true, @OA\Schema(type="integer")), @OA\Response(response=200, description="Service event deleted", @OA\JsonContent(type="object")))
     */
    public function servicesAndAttendance(): void
    {
    }

    /**
     * @OA\Get(path="/api/guests", tags={"People"}, summary="List guests", security={{"bearerAuth": {}}}, @OA\Response(response=200, description="Guests list", @OA\JsonContent(type="object")))
     * @OA\Post(path="/api/guests", tags={"People"}, summary="Create a guest", security={{"bearerAuth": {}}}, @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=201, description="Guest created", @OA\JsonContent(type="object")))
     * @OA\Get(path="/api/guests/{guest}", tags={"People"}, summary="Show a guest", security={{"bearerAuth": {}}}, @OA\Parameter(name="guest", in="path", required=true, @OA\Schema(type="integer")), @OA\Response(response=200, description="Guest", @OA\JsonContent(type="object")))
     * @OA\Put(path="/api/guests/{guest}", tags={"People"}, summary="Update a guest", security={{"bearerAuth": {}}}, @OA\Parameter(name="guest", in="path", required=true, @OA\Schema(type="integer")), @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=200, description="Guest updated", @OA\JsonContent(type="object")))
     * @OA\Delete(path="/api/guests/{guest}", tags={"People"}, summary="Delete a guest", security={{"bearerAuth": {}}}, @OA\Parameter(name="guest", in="path", required=true, @OA\Schema(type="integer")), @OA\Response(response=200, description="Guest deleted", @OA\JsonContent(type="object")))
     * @OA\Get(path="/api/children", tags={"People"}, summary="List children", security={{"bearerAuth": {}}}, @OA\Response(response=200, description="Children list", @OA\JsonContent(type="object")))
     * @OA\Post(path="/api/children", tags={"People"}, summary="Create a child", security={{"bearerAuth": {}}}, @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=201, description="Child created", @OA\JsonContent(type="object")))
     * @OA\Get(path="/api/children/{child}", tags={"People"}, summary="Show a child", security={{"bearerAuth": {}}}, @OA\Parameter(name="child", in="path", required=true, @OA\Schema(type="integer")), @OA\Response(response=200, description="Child", @OA\JsonContent(type="object")))
     * @OA\Put(path="/api/children/{child}", tags={"People"}, summary="Update a child", security={{"bearerAuth": {}}}, @OA\Parameter(name="child", in="path", required=true, @OA\Schema(type="integer")), @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=200, description="Child updated", @OA\JsonContent(type="object")))
     * @OA\Delete(path="/api/children/{child}", tags={"People"}, summary="Delete a child", security={{"bearerAuth": {}}}, @OA\Parameter(name="child", in="path", required=true, @OA\Schema(type="integer")), @OA\Response(response=200, description="Child deleted", @OA\JsonContent(type="object")))
     */
    public function guestsAndChildren(): void
    {
    }

    /**
     * @OA\Get(path="/api/leaders", tags={"People"}, summary="List leaders", security={{"bearerAuth": {}}}, @OA\Response(response=200, description="Leaders list", @OA\JsonContent(type="object")))
     * @OA\Post(path="/api/leaders", tags={"People"}, summary="Create a leader", security={{"bearerAuth": {}}}, @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=201, description="Leader created", @OA\JsonContent(type="object")))
     * @OA\Put(path="/api/leaders/{id}", tags={"People"}, summary="Update a leader", security={{"bearerAuth": {}}}, @OA\Parameter(name="id", in="path", required=true, @OA\Schema(type="integer")), @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=200, description="Leader updated", @OA\JsonContent(type="object")))
     * @OA\Delete(path="/api/leaders/{id}", tags={"People"}, summary="Delete a leader", security={{"bearerAuth": {}}}, @OA\Parameter(name="id", in="path", required=true, @OA\Schema(type="integer")), @OA\Response(response=200, description="Leader deleted", @OA\JsonContent(type="object")))
     * @OA\Post(path="/api/leaders/{id}/retire", tags={"People"}, summary="Retire a leader", security={{"bearerAuth": {}}}, @OA\Parameter(name="id", in="path", required=true, @OA\Schema(type="integer")), @OA\Response(response=200, description="Leader retired", @OA\JsonContent(type="object")))
     * @OA\Post(path="/api/leaders/{id}/restore", tags={"People"}, summary="Restore a retired leader", security={{"bearerAuth": {}}}, @OA\Parameter(name="id", in="path", required=true, @OA\Schema(type="integer")), @OA\Response(response=200, description="Leader restored", @OA\JsonContent(type="object")))
     * @OA\Put(path="/api/leaders/{id}/roles", tags={"People"}, summary="Update leader roles", security={{"bearerAuth": {}}}, @OA\Parameter(name="id", in="path", required=true, @OA\Schema(type="integer")), @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=200, description="Leader roles updated", @OA\JsonContent(type="object")))
     * @OA\Get(path="/api/retired-leaders", tags={"People"}, summary="List retired leaders", security={{"bearerAuth": {}}}, @OA\Response(response=200, description="Retired leaders", @OA\JsonContent(type="object")))
     * @OA\Get(path="/api/leadership-roles", tags={"People"}, summary="List leadership roles", security={{"bearerAuth": {}}}, @OA\Response(response=200, description="Leadership roles", @OA\JsonContent(type="object")))
     * @OA\Post(path="/api/leadership-roles", tags={"People"}, summary="Create a leadership role", security={{"bearerAuth": {}}}, @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=201, description="Leadership role created", @OA\JsonContent(type="object")))
     * @OA\Put(path="/api/leadership-roles/{id}", tags={"People"}, summary="Update a leadership role", security={{"bearerAuth": {}}}, @OA\Parameter(name="id", in="path", required=true, @OA\Schema(type="integer")), @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=200, description="Leadership role updated", @OA\JsonContent(type="object")))
     * @OA\Delete(path="/api/leadership-roles/{id}", tags={"People"}, summary="Delete a leadership role", security={{"bearerAuth": {}}}, @OA\Parameter(name="id", in="path", required=true, @OA\Schema(type="integer")), @OA\Response(response=200, description="Leadership role deleted", @OA\JsonContent(type="object")))
     */
    public function leaders(): void
    {
    }

    /**
     * @OA\Get(path="/api/contributions", tags={"Finance"}, summary="List contributions", security={{"bearerAuth": {}}}, @OA\Response(response=200, description="Contributions list", @OA\JsonContent(type="object")))
     * @OA\Post(path="/api/contributions", tags={"Finance"}, summary="Create a contribution", security={{"bearerAuth": {}}}, @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=201, description="Contribution created", @OA\JsonContent(type="object")))
     * @OA\Delete(path="/api/contributions/{id}", tags={"Finance"}, summary="Delete a contribution", security={{"bearerAuth": {}}}, @OA\Parameter(name="id", in="path", required=true, @OA\Schema(type="integer")), @OA\Response(response=200, description="Contribution deleted", @OA\JsonContent(type="object")))
     * @OA\Get(path="/api/contributors", tags={"Finance"}, summary="List contributors", security={{"bearerAuth": {}}}, @OA\Response(response=200, description="Contributors list", @OA\JsonContent(type="object")))
     * @OA\Get(path="/api/contribution-types", tags={"Finance"}, summary="List contribution types", security={{"bearerAuth": {}}}, @OA\Response(response=200, description="Contribution types", @OA\JsonContent(type="object")))
     * @OA\Post(path="/api/contribution-types", tags={"Finance"}, summary="Create a contribution type", security={{"bearerAuth": {}}}, @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=201, description="Contribution type created", @OA\JsonContent(type="object")))
     * @OA\Get(path="/api/assets", tags={"Finance"}, summary="List assets", security={{"bearerAuth": {}}}, @OA\Response(response=200, description="Assets list", @OA\JsonContent(type="object")))
     * @OA\Post(path="/api/assets", tags={"Finance"}, summary="Create an asset", security={{"bearerAuth": {}}}, @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=201, description="Asset created", @OA\JsonContent(type="object")))
     * @OA\Put(path="/api/assets/{asset}", tags={"Finance"}, summary="Update an asset", security={{"bearerAuth": {}}}, @OA\Parameter(name="asset", in="path", required=true, @OA\Schema(type="integer")), @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=200, description="Asset updated", @OA\JsonContent(type="object")))
     * @OA\Delete(path="/api/assets/{asset}", tags={"Finance"}, summary="Delete an asset", security={{"bearerAuth": {}}}, @OA\Parameter(name="asset", in="path", required=true, @OA\Schema(type="integer")), @OA\Response(response=200, description="Asset deleted", @OA\JsonContent(type="object")))
     */
    public function finance(): void
    {
    }

    /**
     * @OA\Post(path="/api/send-sms", tags={"SMS"}, summary="Send SMS", security={{"bearerAuth": {}}}, @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=200, description="SMS sent", @OA\JsonContent(type="object")))
     * @OA\Get(path="/api/sms/logs", tags={"SMS"}, summary="List SMS logs", security={{"bearerAuth": {}}}, @OA\Response(response=200, description="SMS logs", @OA\JsonContent(type="object")))
     * @OA\Get(path="/api/dashboard-verse", tags={"Authentication"}, summary="Get dashboard verse setting", security={{"bearerAuth": {}}}, @OA\Response(response=200, description="Dashboard verse", @OA\JsonContent(type="object")))
     * @OA\Post(path="/api/dashboard-verse", tags={"Authentication"}, summary="Save dashboard verse setting", security={{"bearerAuth": {}}}, @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")), @OA\Response(response=200, description="Dashboard verse saved", @OA\JsonContent(type="object")))
     */
    public function misc(): void
    {
    }
}
