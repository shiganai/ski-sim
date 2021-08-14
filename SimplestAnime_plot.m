classdef SimplestAnime_plot < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure         matlab.ui.Figure
        thSlider         matlab.ui.control.Slider
        PlayButton       matlab.ui.control.StateButton
        tEditFieldLabel  matlab.ui.control.Label
        tEditField       matlab.ui.control.NumericEditField
        axAnime          matlab.ui.control.UIAxes
    end

    
    properties (Access = public)
        pAnimes        matlab.graphics.chart.primitive.Scatter
        time           double
        xArray         double
        yArray         double
        zArray         double
        pauseTime      double
        lines          matlab.graphics.primitive.Line
        sliders        matlab.ui.control.Slider
    end
    
    
    methods (Access = private)
        
        function setPsandLines(app,targetIndex)
            for i = 1:length(app.xArray(1, :))
                app.pAnimes(i).XData = app.xArray(targetIndex, i);
                app.pAnimes(i).YData = app.yArray(targetIndex, i);
                app.pAnimes(i).ZData = app.zArray(targetIndex, i);
            end
            
            for i = 1:length(app.xArray(1, :)) - 1
                app.lines(i).XData = ...
                    [app.xArray(targetIndex, i), app.xArray(targetIndex, i+1)];
                app.lines(i).YData =...
                    [app.yArray(targetIndex, i), app.yArray(targetIndex, i+1)];
                app.lines(i).ZData =...
                    [app.zArray(targetIndex, i), app.zArray(targetIndex, i+1)];
            end
            
        end
        
        function setSliders(app, value)
            for i = app.sliders
                i.Value = value;
            end
        end
        
        
        
    end
    
    methods (Access = public)
        function restartupFcn(app, time, xArray, yArray, zArray)
            startupFcn(app, time, xArray, yArray, zArray)
            setSliders(app, 1)
        end
        
        function FirstPlay(app)
            app.PlayButton.Value = true;
            startTime = floor(app.thSlider.Value);
            if startTime ~= app.thSlider.Limits(2)
                for i = [startTime:ceil(app.pauseTime/(app.time(2)-app.time(1))):length(app.time), length(app.time)]
                    if ~app.PlayButton.Value
                        break
                    end
                    
                    setSliders(app, i);
                    setPsandLines(app,i);
                    app.tEditField.Value = app.time(i);
                    
                    drawnow
                    pause(app.pauseTime);
                end
            else
                for i = [1:ceil(app.pauseTime/(app.time(2)-app.time(1))):length(app.time),...
                        length(app.time)]
                    if ~app.PlayButton.Value
                        break
                    end
                    
                    setSliders(app, i);
                    setPsandLines(app,i);
                    app.tEditField.Value = app.time(i);
                    
                    drawnow
                    pause(app.pauseTime);
                end
            end
            app.PlayButton.Value = false;
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, time, xArray, yArray, zArray)
            if length(xArray)~=length(yArray)
                throw(MException('MyComponet:SizeMissmatching', 'x座標とy座標の数が合いません'))
            end
            
            %----------------------------------------------------
            %-----------------データの入力------------------------
            %----------------------------------------------------
            app.time = time;
            app.xArray = xArray;
            app.yArray = yArray;
            app.zArray = zArray;
            app.sliders = app.thSlider;
            app.tEditField.Value = app.time(1);
            
            app.pauseTime = 0.05;
            
            
            %----------------------------------------------------
            %-----------------関節の表示--------------------------
            %----------------------------------------------------
%             app.pAnimes(1) = scatter3(app.axAnime, app.xArray(1, 1), app.yArray(1, 1), app.zArray(1, 1));
            hold(app.axAnime, 'on')
            for i = 1:length(app.xArray(1, :))
                app.pAnimes(i) = scatter3(app.axAnime, app.xArray(1, i), app.yArray(1, i), app.zArray(1, i), 'r', 'fill');
            end
            hold(app.axAnime, 'off')
            
            %----------------------------------------------------
            %-----------------身体の表示--------------------------
            %----------------------------------------------------
            for i = 1:length(app.xArray(1, :)) - 1
                app.lines(i) = line(app.axAnime,...
                    [app.xArray(1, i), app.xArray(1, i+1)],...
                    [app.yArray(1, i), app.yArray(1, i+1)],...
                    [app.zArray(1, i), app.zArray(1, i+1)] ...
                    );
            end
            
            
            %----------------------------------------------------
            %-----------------スライダーの設定--------------------
            %----------------------------------------------------
            
            app.thSlider.Limits = [1, length(app.time)];
            drawnow
            try_num = 0;
            while true
                try
                    app.thSlider.MajorTickLabels = cellstr(num2str(time(app.thSlider.MajorTicks)));
                    break
                catch
                    pause(app.pauseTime)
                    try_num = try_num + 1;
                end
            end
            
        end

        % Value changed function: PlayButton
        function PlayButtonValueChanged(app, event)
            value = app.PlayButton.Value;
            if value
                startTime = floor(app.thSlider.Value);
                if startTime ~= app.thSlider.Limits(2)
                    for i = [startTime:ceil(app.pauseTime/(app.time(2)-app.time(1))):length(app.time), length(app.time)]
                        
                        if ~app.PlayButton.Value
                            break
                        end
                        
                        setSliders(app, i);
                        setPsandLines(app,i);
                        app.tEditField.Value = app.time(i);
                        
                        drawnow
                        pause(app.pauseTime);
                    end
                else
                    for i = [1:ceil(app.pauseTime/(app.time(2)-app.time(1))):length(app.time),...
                            length(app.time)]
                        if ~app.PlayButton.Value
                            break
                        end
                        
                        setSliders(app, i);
                        setPsandLines(app,i);
                        app.tEditField.Value = app.time(i);
                        
                        drawnow
                        pause(app.pauseTime);
                    end
                end
                app.PlayButton.Value = false;
            end
        end

        % Value changing function: thSlider
        function sliderValueChanging(app, event)
            changingValue = event.Value;
            setSliders(app, floor(changingValue + 0.5));
            setPsandLines(app,floor(changingValue + 0.5));
            app.tEditField.Value = app.time(floor(changingValue + 0.5));
        end

        % Close request function: UIFigure
        function UIFigureCloseRequest(app, event)
            delete(app)
        end

        % Value changed function: tEditField
        function tEditFieldValueChanged(app, event)
            value = app.tEditField.Value;
            targetIndex = floor(value/(app.time(2)-app.time(1)));
            setSliders(app, targetIndex)
            setPsandLines(app,targetIndex);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 783 700];
            app.UIFigure.Name = 'UI Figure';
            app.UIFigure.CloseRequestFcn = createCallbackFcn(app, @UIFigureCloseRequest, true);

            % Create thSlider
            app.thSlider = uislider(app.UIFigure);
            app.thSlider.Limits = [0 5];
            app.thSlider.ValueChangingFcn = createCallbackFcn(app, @sliderValueChanging, true);
            app.thSlider.Position = [185 70 417 3];

            % Create PlayButton
            app.PlayButton = uibutton(app.UIFigure, 'state');
            app.PlayButton.ValueChangedFcn = createCallbackFcn(app, @PlayButtonValueChanged, true);
            app.PlayButton.Text = 'Play';
            app.PlayButton.Position = [343 600 100 22];

            % Create tEditFieldLabel
            app.tEditFieldLabel = uilabel(app.UIFigure);
            app.tEditFieldLabel.HorizontalAlignment = 'right';
            app.tEditFieldLabel.Position = [323 114 25 22];
            app.tEditFieldLabel.Text = 't';

            % Create tEditField
            app.tEditField = uieditfield(app.UIFigure, 'numeric');
            app.tEditField.ValueChangedFcn = createCallbackFcn(app, @tEditFieldValueChanged, true);
            app.tEditField.Position = [363 114 100 22];

            % Create axAnime
            app.axAnime = uiaxes(app.UIFigure);
            xlabel(app.axAnime, 'x')
            ylabel(app.axAnime, 'y')
            app.axAnime.PlotBoxAspectRatio = [1.05424528301887 1 1];
            app.axAnime.TitleFontWeight = 'bold';
            app.axAnime.Position = [193 151 400 400];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = SimplestAnime_plot(varargin)

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @(app)startupFcn(app, varargin{:}))

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end