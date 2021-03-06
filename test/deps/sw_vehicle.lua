require("./utility.lua");

input = {};
output = {};
property = {};
screen = {};
map = {};
async = {};

testsuite = {
    event = {}
}

function testsuite.event.onDraw()
    if onDraw then
        onDraw()
    end
end
function testsuite.event.onTick()
    if onTick then
        --[[
            simulate screen functions not available
            in onTick
        ]]
        local lateboundScreen = screen;
        screen = {};

        onTick();

        screen = lateboundScreen;
    end
end

function input.test_setBool(index, value)
    input[index] = value;
end
function input.test_setNumber(index, value)
    input[index] = value;
end
function input.getBool(index)
    assureParameterInBounds("index", index, 1, 32);
    return input[index];
end
function input.getNumber(index)
    assureParameterInBounds("index", index, 1, 32);
    return input[index];
end

function output.test_getBool(index)
    return output[index];
end
function output.test_getNumber(index)
    return output[index];
end
function output.setBool(index, value)
    assureParameterInBounds("index", index, 1, 32);
    output[index] = value;
end
function output.setNumber(index, value)
    assureParameterInBounds("index", index, 1, 32);
    output[index] = value;
end

function property.test_setNumber(label, value)
    property[label] = value;
end
function property.test_setBool(label, value)
    property[label] = value;
end
function property.test_setText(label, value)
    property[label] = value;
end
function property.getNumber(label)
    assureNotNil("label", label);
    local numberProperty = property[label];
    assureNotNil("numberProperty", numberProperty);
    return numberProperty;
end
function property.getBool(label)
    assureNotNil("label", label);
    local numberProperty = property[label];
    assureNotNil("numberProperty", numberProperty);
    return numberProperty;
end
function property.getText(label)
    assureNotNil("label", label);
    local numberProperty = property[label];
    assureNotNil("numberProperty", numberProperty);
    return numberProperty;
end

function screen.setColor(r, g, b)
    assureColorInBounds(r, b, b, 1);
    printf("Color set to %d, %d, %d", r, g, b);
end
function screen.setColor(r, g, b, a)
    assureColorInBounds(r, b, b, a);
    printf("Color set to %d, %d, %d, %f", r, g, b, a);
end
function screen.drawClear()
    print("Screen cleared");
end
function screen.drawLine(x1, y1, x2, y2)
    printf("Line drawn on %d, %d, %d, %d", x1, y1, x2, y2);
end
function screen.drawCircle(x, y, radius)
    printf("Circle drawn on %d, %d with %d", x, y, radius);
end
function screen.drawCircleF(x, y, radius)
    printf("Filled Circle drawn on %d, %d with %d", x, y, radius);
end
function screen.drawRect(x, y, width, height)
    printf("Rectangle drawn on %d, %d with %d, %d", x, y, width, height);
end
function screen.drawRectF(x, y, width, height)
    printf("Filled rectangle drawn on %d, %d with %d, %d", x, y, width, height);
end
function screen.drawTriangle(x1, y1, x2, y2, x3, y3)
    printf("Triangle drawn on %d, %d, %d, %d, %d, %d", x1, y1, x2, y2, x3, y3);
end
function screen.drawTriangleF(x1, y1, x2, y2, x3, y3)
    printf("Filled triangle drawn on %d, %d, %d, %d, %d, %d", x1, y1, x2, y2, x3, y3);
end
function screen.drawText(x, y, text)
    printf("Text drawn on %d, %d with '%s'", x, y, text);
end
function screen.drawTextBox(x, y, w, h, text, h_align, v_align)
    printf("TextBox drawn on %d, %d with %d, %d, '%s' aligned at %d, %d", x, y, w, h, text, h_align, v_align);
end
function screen.drawMap(x, y, zoom)
    printf("Map drawn on %d, %d with %d", x, y, zoom);
end
function screen.setMapColorOcean(r, g, b, a)
    assureColorInBounds(r, b, b, a);
    printf("Ocean map color set to %d, %d, %d, %f", r, g, b, a);
end
function screen.setMapColorShallows(r, g, b, a)
    assureColorInBounds(r, b, b, a);
    printf("Shallow map color set to %d, %d, %d, %f", r, g, b, a);
end
function screen.setMapColorLand(r, g, b, a)
    assureColorInBounds(r, b, b, a);
    printf("Land map color set to %d, %d, %d, %f", r, g, b, a);
end
function screen.setMapColorGrass(r, g, b, a)
    assureColorInBounds(r, b, b, a);
    printf("Grass map color set to %d, %d, %d, %f", r, g, b, a);
end
function screen.setMapColorSand(r, g, b, a)
    assureColorInBounds(r, b, b, a);
    printf("Sand map color set to %d, %d, %d, %f", r, g, b, a);
end
function screen.setMapColorSnow(r, g, b, a)
    assureColorInBounds(r, b, b, a);
    printf("Snow map color set to %d, %d, %d, %f", r, g, b, a);
end
function screen.test_setWidth(width)
    screen.width = width;
end
function screen.test_setHeight(height)
    screen.height = height;
end
function screen.getWidth()
    return screen.width;
end
function screen.getHeight()
    return screen.height;
end

function map.test_setScreenToMap(worldX, worldY)
    map.worldX = worldX;
    map.worldY = worldY;
end
function map.test_setMapToScreen(pixelX, pixelY)
    map.pixelX = pixelX;
    map.pixelY = pixelY;
end
function map.screenToMap(mapX, mapY, zoom, screenW, screenH, pixelX, pixelY)
    return map.worldX, map.worldY;
end
function map.mapToScreen(mapX, mapY, zoom, screenW, screenH, worldX, worldY)
    return map.pixelX, map.pixelY;
end
function async.test_setHttpGetCallback(callback)
    async.callback = callback;
end
function async.httpGet(port, request_body)
    httpReply(port, request_body, async.callback(port, request_body));
end

--[[
-- Revised on v0.10.33
function async.test_setHTTPRequestResponse(success, response)
    async.success = success;
    async.response = response;
end
function async.HTTPRequest(fail_callback, success_callback, url, method, headers, body)
    if async.success then
        success_callback(async.response)
    else
        fail_callback()
    end
end
]]